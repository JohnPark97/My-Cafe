class ApplicationController < ActionController::Base
  def index
    @categories = Category.includes(:menus)
  end
end
