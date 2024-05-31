# app/models/menu_item.rb
class MenuItem < ApplicationRecord
  mount_uploader :image_url, ImageUploader
  belongs_to :category
  belongs_to :cafe

  validates :name, :price, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
