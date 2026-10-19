
class StatisticsController < ApplicationController
  before_action :require_login

  def index
    library = current_user.user_items.includes(item: :genres)

    @total_movies = library.count
    @completed_movies = library.where(status: "completed").count
    @in_progress_movies = library.where(status: "in_progress").count
    @planned_movies = library.where(status: "want").count

    @rated_movies = library.where.not(rating: nil).count
    @average_personal_rating = library.average(:rating)&.round(1)


@genre_stats = Genre
  .joins(items: :user_items)
  .where(user_items: { user_id: current_user.id })
  .where(items: { item_type: "movie" })
  .group(:name)
  .distinct
  .count("items.id")
  .sort_by { |_, count| -count }
  .first(5)
  end

  private

  def require_login
    return if current_user

    redirect_to "/login", alert: "Войди в аккаунт, чтобы посмотреть статистику."
  end
end
