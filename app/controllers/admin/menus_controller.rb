class Admin::MenusController < ApplicationController
  include S3Helper
  before_action :authenticate_user!
  before_action :admin_only
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = Menu.all
  end

  def show
    Rails.logger.info "Showing menu: #{@menu.inspect}"
    if @menu.image_url.present?
      @signed_url = generate_signed_url(@menu)
      Rails.logger.info "Generated signed URL: #{@signed_url}"
    else
      Rails.logger.info "No image URL present for menu."
    end
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def create
    Rails.logger.info "Menu params (create): #{menu_params.inspect}"
    @menu = Menu.new(menu_params)

    if @menu.save
      Rails.logger.info "Menu successfully created: #{@menu.inspect}"
      redirect_to admin_menus_path, notice: 'Menu was successfully created.'
    else
      Rails.logger.error "Failed to create menu: #{@menu.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def update
    Rails.logger.info "Menu params (update): #{menu_params.inspect}"
    if @menu.update(menu_params)
      Rails.logger.info "Menu successfully updated: #{@menu.inspect}"
      redirect_to admin_menus_path, notice: 'Menu was successfully updated.'
    else
      Rails.logger.error "Failed to update menu: #{@menu.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  def destroy
    if @menu.destroy
      Rails.logger.info "Menu successfully destroyed: #{@menu.inspect}"
    else
      Rails.logger.error "Failed to destroy menu: #{@menu.errors.full_messages.join(", ")}"
    end
    redirect_to admin_menus_path, notice: 'Menu was successfully destroyed.'
  end

  private

  def admin_only
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :description, :price, :availability, :category_id, :image_url)
  end
end
