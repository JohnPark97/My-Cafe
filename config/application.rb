require_relative "boot"

require "rails/all"
require_relative "../app/middleware/switch_tenant" # Update the path if necessary

Bundler.require(*Rails.groups)

module MyCafe
  class Application < Rails::Application
    config.load_defaults 7.1

    # Add custom middleware to switch tenant schemas
    config.middleware.use SwitchTenant

    config.autoload_lib(ignore: %w(assets tasks))
    config.assets.paths << Rails.root.join("app", "assets", "images")
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
    config.assets.paths << Rails.root.join("app", "assets", "javascripts")

    config.assets.precompile = %w(application.js application.css)
  end
end
