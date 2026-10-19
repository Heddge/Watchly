class AddTmdbRatingToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items, :tmdb_rating, :decimal, precision: 4, scale: 2
  end
end
