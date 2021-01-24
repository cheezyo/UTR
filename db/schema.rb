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

ActiveRecord::Schema.define(version: 2021_01_24_161203) do

  create_table "players", force: :cascade do |t|
    t.integer "utr_player_id"
    t.string "name"
    t.date "birthdate"
    t.integer "birthyear"
    t.string "member_id"
    t.string "ranking_category"
    t.float "utr"
    t.integer "reliability"
    t.string "profile_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ranking_imports", force: :cascade do |t|
    t.date "rank_date"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "player_id"
    t.integer "ranking_import_id"
    t.float "utr"
    t.integer "reliability"
    t.integer "utr_player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ranking_category"
    t.integer "birthyear"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
