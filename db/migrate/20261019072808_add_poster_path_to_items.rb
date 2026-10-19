class AddPosterPathToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items, :poster_path, :string
  end
end
