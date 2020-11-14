# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_09_210922) do

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "pile_id"
  end

  create_table "piles", force: :cascade do |t|
    t.string "name"
    t.string "creator"
    t.boolean "private_pile"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_players"
    t.string "game_type"
    t.boolean "private"
    t.string "room_code"
    t.index ["room_code"], name: "index_rooms_on_room_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "email"
    t.string "password_digest"
    t.string "provider"
    t.string "session_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
