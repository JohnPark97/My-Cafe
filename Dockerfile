# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.3.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Create a non-root user and group
RUN addgroup --system rails && adduser --system --ingroup rails rails

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git libvips node-gyp pkg-config python-is-python3 libpq-dev

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Set RAILS_MASTER_KEY for assets precompilation
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

# Precompiling assets for production
RUN bundle exec rails assets:precompile

# Copy entrypoint script and set permissions
COPY ./bin/docker-entrypoint /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

# Final stage for app image
FROM base

# Install packages needed for deployment, including libpq
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips libpq5 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Create and set permissions for required directories
RUN mkdir -p /rails/public/assets && \
    mkdir -p /rails/tmp && \
    mkdir -p /rails/log && \
    mkdir -p /rails/storage && \
    chown -R rails:rails /rails/public/assets /rails/tmp /rails/log /rails/storage && \
    chmod -R 775 /rails/public/assets /rails/tmp /rails/log /rails/storage

# Set permissions for the entire application directory
RUN chown -R rails:rails /rails

# Switch to the non-root user
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3009
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3009"]
