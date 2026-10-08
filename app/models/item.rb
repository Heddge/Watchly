class Item < ApplicationRecord
  has_many :user_items, dependent: :destroy
has_many :users, through: :user_items

has_many :item_genres, dependent: :destroy
has_many :genres, through: :item_genres

  validates :title, presence: true
  validates :item_type, inclusion: { in: %w[movie game book] }
  validates :release_year, presence: true,
                           numericality: {
                             only_integer: true,
                             greater_than: 1800,
                             less_than_or_equal_to: Date.current.year
                           }

  def movie?
    item_type == "movie"
  end

  def game?
    item_type == "game"
  end

  def book?
    item_type == "book"
  end
end
