# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate_cafe_admin_user!
  before_action :admin_only

  private

  # Alias current_cafe_admin_user to current_user for simplicity
  def current_user
    current_cafe_admin_user
  end

  def admin_only
    redirect_to root_path, alert: 'Access denied.' unless current_user&.admin?
  end
end
