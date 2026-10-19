
class AddTmdbIdToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items, :tmdb_id, :integer
    add_index :items, :tmdb_id, unique: true
  end
end
