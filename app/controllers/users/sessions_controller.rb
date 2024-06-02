# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  before_action :set_cafe_schema, only: [:create]

  private

  def set_cafe_schema
    # Extract subdomain or cafe_id from the request to find the cafe
    cafe = if request.subdomain.present? && request.subdomain != 'www'
             Cafe.find_by(subdomain: request.subdomain)
           elsif params[:cafe_id]
             Cafe.find(params[:cafe_id])
           end

    if cafe
      ActiveRecord::Base.connection.schema_search_path = cafe.subdomain
    else
      raise ActiveRecord::RecordNotFound, "Cafe not found"
    end
  end
end
