class ApplicationController < ActionController::Base
  before_action :set_tenant_schema

  def index
    @cafes = Cafe.all
  end

  private

  def set_tenant_schema
    if params[:cafe_id]
      ActiveRecord::Base.connection.schema_search_path = 'public'
      cafe = Cafe.find(params[:cafe_id])
      ActiveRecord::Base.connection.schema_search_path = cafe.subdomain
    elsif request.subdomain.present?
      cafe = Cafe.find_by(subdomain: request.subdomain)
      if cafe
        ActiveRecord::Base.connection.schema_search_path = cafe.subdomain
      else
        ActiveRecord::Base.connection.schema_search_path = 'public'
      end
    else
      ActiveRecord::Base.connection.schema_search_path = 'public'
    end
  end
end
