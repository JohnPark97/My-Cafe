class User < ApplicationRecord
  belongs_to :cafe
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Ensure admin flag is boolean
  attribute :admin, :boolean, default: false
  validates :email, presence: true, uniqueness: true

  has_many :orders
  has_many :reviews
end
