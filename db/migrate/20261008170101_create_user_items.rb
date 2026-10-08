class CreateUserItems < ActiveRecord::Migration[8.1]
  def change
    create_table :user_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :status, null: false
      t.integer :rating

      t.timestamps
    end

    add_index :user_items, [ :user_id, :item_id ], unique: true
  end
end
