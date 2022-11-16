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

ActiveRecord::Schema[7.0].define(version: 2022_11_05_204246) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "leaseholders", force: :cascade do |t|
    t.string "property_account", limit: 500
    t.text "description"
    t.integer "capacity"
    t.integer "highlimit"
    t.string "polygon", limit: 1000
    t.integer "area"
    t.string "center", limit: 100
    t.integer "mean_reviews"
    t.integer "credit"
    t.boolean "status"
    t.string "id_picture_front", limit: 500
    t.string "id_picture_back", limit: 500
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_leaseholders_on_user_id"
  end

  create_table "lessors", force: :cascade do |t|
    t.integer "credit"
    t.integer "mean_reviews"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_lessors_on_user_id"
  end

  create_table "rental_agreements", force: :cascade do |t|
    t.datetime "timestamp_start", precision: nil
    t.datetime "timestamp_end", precision: nil
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lessor_id", null: false
    t.bigint "leaseholder_id", null: false
    t.string "reasons", limit: 100
    t.decimal "offer_price"
    t.index ["leaseholder_id"], name: "index_rental_agreements_on_leaseholder_id"
    t.index ["lessor_id"], name: "index_rental_agreements_on_lessor_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "score"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "leaseholder_id", null: false
    t.index ["leaseholder_id"], name: "index_reviews_on_leaseholder_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 100, default: "", null: false
    t.string "encrypted_password", limit: 100, default: "", null: false
    t.string "name", limit: 100
    t.string "picture", limit: 500
    t.string "phone", limit: 15
    t.string "street", limit: 100
    t.string "city", limit: 100
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "leaseholders", "users"
  add_foreign_key "lessors", "users"
  add_foreign_key "rental_agreements", "leaseholders"
  add_foreign_key "rental_agreements", "lessors"
  add_foreign_key "reviews", "leaseholders"
end
