class Admin::MenuItemsController < ApplicationController
  include S3Helper
  # before_action :authenticate_user!
  # before_action :admin_only
  before_action :set_cafe
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  def index
    @menu_items = MenuItem.all
  end

  def show
  end

  def new
    @menu_item = MenuItem.new
  end

  def edit
  end

  def create
    Rails.logger.info "Menu item params (create): #{menu_item_params.inspect}"
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      Rails.logger.info "Menu item successfully created: #{@menu_item.inspect}"
      redirect_to cafe_admin_menu_items_path(@cafe), notice: 'Menu item was successfully created.'
    else
      Rails.logger.error "Failed to create menu item: #{@menu_item.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def update
    Rails.logger.info "Menu item params (update): #{menu_item_params.inspect}"
    if @menu_item.update(menu_item_params)
      Rails.logger.info "Menu item successfully updated: #{@menu_item.inspect}"
      redirect_to cafe_admin_menu_items_path(@cafe), notice: 'Menu item was successfully updated.'
    else
      Rails.logger.error "Failed to update menu item: #{@menu_item.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  def destroy
    if @menu_item.destroy
      Rails.logger.info "Menu item successfully destroyed: #{@menu_item.inspect}"
    else
      Rails.logger.error "Failed to destroy menu item: #{@menu_item.errors.full_messages.join(", ")}"
    end
    redirect_to cafe_admin_menu_items_path(@cafe), notice: 'Menu item was successfully destroyed.'
  end

  private

  def admin_only
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def set_cafe
    @cafe = Cafe.find(params[:cafe_id])
    ActiveRecord::Base.connection.schema_search_path = @cafe.subdomain
  end

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price, :availability, :category_id, :image_url)
  end
end
