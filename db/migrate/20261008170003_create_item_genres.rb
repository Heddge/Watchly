class CreateItemGenres < ActiveRecord::Migration[8.1]
  def change
    create_table :item_genres do |t|
      t.references :item, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
    end

    add_index :item_genres, [ :item_id, :genre_id ], unique: true
  end
end
