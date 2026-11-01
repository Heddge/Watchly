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

  after_commit :broadcast_community_rating, on: [:create, :update, :destroy]

  def rated?
    rating.present?
  end

  def completed?
    status == "completed"
  end

  private

  def broadcast_community_rating
    return unless item

    Turbo::StreamsChannel.broadcast_replace_to(
      "community_rating",
      target: "community_rating_#{item.id}",
      partial: "items/community_rating",
      locals: { item: item }
    )
  end
end