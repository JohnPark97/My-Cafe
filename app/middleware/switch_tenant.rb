# app/middleware/switch_tenant.rb
class SwitchTenant
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)

    if request.params["cafe_id"]
      cafe = Cafe.find_by(id: request.params["cafe_id"])
      if cafe
        schema = cafe.subdomain
        if schema.present?
          ActiveRecord::Base.connection.execute("SET search_path TO #{schema}")
          Thread.current[:tenant] = schema
        else
          Rails.logger.warn("Cafe subdomain is blank, defaulting to public schema.")
        end
      else
        Rails.logger.warn("Cafe not found, defaulting to public schema.")
      end
    end

    @app.call(env)
  end
end
