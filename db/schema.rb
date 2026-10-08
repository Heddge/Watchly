# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_08_170101) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "item_genres", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "genre_id", null: false
    t.index ["genre_id"], name: "index_item_genres_on_genre_id"
    t.index ["item_id", "genre_id"], name: "index_item_genres_on_item_id_and_genre_id", unique: true
    t.index ["item_id"], name: "index_item_genres_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "item_type", null: false
    t.integer "release_year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.string "status", null: false
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_user_items_on_item_id"
    t.index ["user_id", "item_id"], name: "index_user_items_on_user_id_and_item_id", unique: true
    t.index ["user_id"], name: "index_user_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "item_genres", "genres"
  add_foreign_key "item_genres", "items"
  add_foreign_key "user_items", "items"
  add_foreign_key "user_items", "users"
end
