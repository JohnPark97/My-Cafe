class Menu < ApplicationRecord
  belongs_to :category

  validates :name, :description, :price, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
