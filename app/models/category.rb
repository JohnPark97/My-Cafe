class Category < ApplicationRecord
  has_many :menus, dependent: :destroy

  validates :name, presence: true
end
