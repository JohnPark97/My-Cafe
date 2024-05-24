class CategoryController < ApplicationController
  def destroy
    @category.destroy
    redirect_to admin_dashboard_path, notice: 'Category was successfully destroyed.'
  end
end
