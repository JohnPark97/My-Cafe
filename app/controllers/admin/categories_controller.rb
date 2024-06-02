class Admin::CategoriesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :admin_only
  before_action :set_cafe
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @menu_items = Category.find(params[:id]).menu_items
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to cafe_admin_categories_path(@cafe), notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to cafe_admin_categories_path(@cafe), notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to cafe_admin_categories_path(@cafe), notice: 'Category was successfully destroyed.'
  end

  private

  def set_cafe
    @cafe = Cafe.find(params[:cafe_id])
  end

  def admin_only
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
