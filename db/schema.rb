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

ActiveRecord::Schema.define(version: 2020_07_31_081616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hotel_amenities", force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.bigint "amenity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["amenity_id"], name: "index_hotel_amenities_on_amenity_id"
    t.index ["hotel_id"], name: "index_hotel_amenities_on_hotel_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "address"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_messages_on_reservation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "reservation_id", null: false
    t.bigint "hotel_amenity_id", null: false
    t.string "status"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_amenity_id"], name: "index_requests_on_hotel_amenity_id"
    t.index ["reservation_id"], name: "index_requests_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.date "check_in_date"
    t.date "check_out_date"
    t.time "arrival_time"
    t.time "departure_time"
    t.string "reservation_number"
    t.integer "number_of_guests"
    t.string "purpose"
    t.string "channel"
    t.integer "room_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id"], name: "index_reservations_on_hotel_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "time_requests", force: :cascade do |t|
    t.time "time"
    t.boolean "check_in"
    t.string "status"
    t.bigint "reservation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reservation_id"], name: "index_time_requests_on_reservation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "hotel_amenities", "amenities"
  add_foreign_key "hotel_amenities", "hotels"
  add_foreign_key "messages", "reservations"
  add_foreign_key "messages", "users"
  add_foreign_key "requests", "hotel_amenities"
  add_foreign_key "requests", "reservations"
  add_foreign_key "reservations", "hotels"
  add_foreign_key "reservations", "users"
  add_foreign_key "time_requests", "reservations"
end
