class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :status, inclusion: { in: %w[want in_progress completed] }

  validates :rating,
            numericality: {
              only_integer: true,
              in: 1..10
            },
            allow_nil: true

  def rated?
    rating.present?
  end

  def completed?
    status == "completed"
  end
end
