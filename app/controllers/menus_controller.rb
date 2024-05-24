class Admin::MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = Menu.all
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      redirect_to admin_menu_path(@menu), notice: 'Menu was successfully created.'
    else
      render :new
    end
  end

  def update
    if @menu.update(menu_params)
      redirect_to admin_menu_path(@menu), notice: 'Menu was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to admin_menus_url, notice: 'Menu was successfully destroyed.'
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :description, :price, :availability, :category_id)
  end
end
