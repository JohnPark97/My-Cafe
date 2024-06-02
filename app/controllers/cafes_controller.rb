class CafesController < ApplicationController
  before_action :set_cafe

  def show
    @categories = Category.all
  end

  private

  def set_cafe
    @cafe = Cafe.find(params[:id])
    ActiveRecord::Base.connection.schema_search_path = @cafe.subdomain
  end
end
