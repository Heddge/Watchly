class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :description
      t.string :item_type, null: false
      t.integer :release_year, null: false

      t.timestamps
    end
  end
end
