# app/controllers/admin/users/sessions_controller.rb
class Admin::Users::SessionsController < Devise::SessionsController
  before_action :set_tenant, only: [:new, :create]

  private

  def set_tenant
    if params[:user] && params[:user][:email]
      user = find_user_by_email(params[:user][:email])
      if user && user.cafe
        schema = user.cafe.subdomain
        if schema.present?
          ActiveRecord::Base.connection.execute("SET search_path TO #{schema}")
          Thread.current[:tenant] = schema
        else
          Rails.logger.warn("User's cafe subdomain is blank, defaulting to public schema.")
        end
      else
        Rails.logger.warn("User not found or user's cafe not found, defaulting to public schema.")
      end
    end
  end

  def find_user_by_email(email)
    schemas = Cafe.pluck(:subdomain)
    schemas.each do |schema|
      ActiveRecord::Base.connection.execute("SET search_path TO #{schema}")
      user = User.find_by(email: email)
      return user if user
    end
    nil
  end
end
