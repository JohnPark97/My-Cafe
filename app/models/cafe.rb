# app/models/cafe.rb
class Cafe < ApplicationRecord
  validates :name, :subdomain, presence: true
  validates :subdomain, presence: true, uniqueness: true

  has_many :users
  has_many :categories
  has_many :menu_items, through: :categories
end
