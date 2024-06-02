# app/middleware/switch_tenant.rb
class SwitchTenant
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)

    if request.session[:user_id]
      user = User.find_by(id: request.session[:user_id])
      if user && user.cafe
        schema = user.cafe.subdomain
        if schema.present?
          ActiveRecord::Base.connection.execute("SET search_path TO #{schema}")
          Thread.current[:tenant] = schema
        else
          Rails.logger.warn("User's cafe subdomain is blank, defaulting to public schema.")
        end
      else
        Rails.logger.warn("User or user's cafe not found, defaulting to public schema.")
      end
    end

    @app.call(env)
  ensure
    # Reset to public schema after each request
    ActiveRecord::Base.connection.execute("SET search_path TO public")
    Thread.current[:tenant] = nil
  end
end
