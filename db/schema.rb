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

ActiveRecord::Schema[7.0].define(version: 2022_10_10_041256) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "api_v1_admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_v1_leaseholders", force: :cascade do |t|
    t.string "property_account"
    t.geometry "polygon", limit: {:srid=>0, :type=>"st_polygon"}
    t.integer "mean_reviews"
    t.integer "credit"
    t.boolean "status"
    t.string "id_picture_front"
    t.string "id_picture_back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_api_v1_leaseholders_on_user_id"
  end

  create_table "api_v1_lessors", force: :cascade do |t|
    t.integer "credit"
    t.integer "mean_reviews"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_api_v1_lessors_on_user_id"
  end

  create_table "api_v1_rental_agreements", force: :cascade do |t|
    t.datetime "timestamp_start", precision: nil
    t.datetime "timestamp_end", precision: nil
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "api_v1_lessor_id", null: false
    t.bigint "api_v1_leaseholder_id", null: false
    t.index ["api_v1_leaseholder_id"], name: "index_api_v1_rental_agreements_on_api_v1_leaseholder_id"
    t.index ["api_v1_lessor_id"], name: "index_api_v1_rental_agreements_on_api_v1_lessor_id"
  end

  create_table "api_v1_reviews", force: :cascade do |t|
    t.integer "score"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "api_v1_leaseholders_id", null: false
    t.index ["api_v1_leaseholders_id"], name: "index_api_v1_reviews_on_api_v1_leaseholders_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", precision: nil, null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "picture"
    t.string "phone"
    t.string "street"
    t.string "city"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "api_v1_leaseholders", "users"
  add_foreign_key "api_v1_lessors", "users"
  add_foreign_key "api_v1_rental_agreements", "api_v1_leaseholders"
  add_foreign_key "api_v1_rental_agreements", "api_v1_lessors"
  add_foreign_key "api_v1_reviews", "api_v1_leaseholders", column: "api_v1_leaseholders_id"
end
