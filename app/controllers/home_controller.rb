
class HomeController < ApplicationController
  def index
    @top_movies = Item.where(item_type: "movie")
                      .where.not(tmdb_rating: nil)
                      .order(tmdb_rating: :desc, title: :asc)
                      .limit(50)

    if current_user
      library = current_user.user_items

      @user_items = library
                    .includes(item: :genres)
                    .order(updated_at: :desc)

      @recent_user_items = library
                           .includes(item: :genres)
                           .order(created_at: :desc)
                           .limit(5)

      @library_item_ids = @user_items.map(&:item_id)

      @total_movies = library.count
      @completed_movies = library.where(status: "completed").count
      @rated_movies = library.where.not(rating: nil).count
      @average_personal_rating = library.average(:rating)&.round(1)
    else
      @user_items = []
      @recent_user_items = []
      @library_item_ids = []

      @total_movies = 0
      @completed_movies = 0
      @rated_movies = 0
      @average_personal_rating = nil
    end
  end
end
