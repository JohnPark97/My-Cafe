class ApplicationController < ActionController::Base
  include S3Helper

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
