class User < ApplicationRecord
  belongs_to :cafe

  # Devise modules for authentication and user management
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Ensure admin flag is boolean
  attribute :admin, :boolean, default: false

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Associations
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  # Ensure admin attribute is boolean
  after_initialize :set_default_admin

  private

  def set_default_admin
    self.admin ||= false
  end
end
