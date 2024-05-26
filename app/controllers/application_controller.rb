class ApplicationController < ActionController::Base
  include S3Helper

  # Ensure Devise modules are included
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Parameter sanitization for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
  end

  def index
    @categories = Category.includes(:menus).all

    @signed_urls = {}
    @categories.each do |category|
      category.menus.each do |menu|
        if menu.image_url.present?
          @signed_urls[menu.id] = generate_signed_url(menu)
        end
      end
    end
  end
end
