class User < ApplicationRecord
  has_secure_password

  has_many :user_items, dependent: :destroy
  has_many :items, through: :user_items

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  def rated_items
    user_items.where.not(rating: nil).includes(:item).map(&:item)
  end

  def average_rating
    user_items.where.not(rating: nil).average(:rating)
  end
end
