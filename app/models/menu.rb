class Menu < ApplicationRecord
  belongs_to :category

  mount_uploader :image_url, ImageUploader

  validates :name, :description, :price, :category_id, presence: true

  private

  def update_image_url
    if image_url.present? && image_url_changed?
      self.image_url = image_url.url
    end
  end
end
