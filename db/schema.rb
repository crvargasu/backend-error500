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

ActiveRecord::Schema[7.0].define(version: 2022_09_27_151802) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaseholders", force: :cascade do |t|
    t.string "property_account"
    t.geometry "polygon", limit: {:srid=>0, :type=>"st_polygon"}
    t.integer "mean_reviews"
    t.integer "credit"
    t.boolean "status"
    t.string "id_picture_front"
    t.string "id_picture_back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessors", force: :cascade do |t|
    t.integer "credit"
    t.integer "mean_reviews"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rental_agreements", force: :cascade do |t|
    t.datetime "timestamp_start", precision: nil
    t.datetime "timestamp_end", precision: nil
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lessor_id", null: false
    t.bigint "leaseholder_id", null: false
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
    t.string "name"
    t.string "picture"
    t.string "phone"
    t.string "email"
    t.string "street"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "rental_agreements", "leaseholders"
  add_foreign_key "rental_agreements", "lessors"
  add_foreign_key "reviews", "leaseholders"
end
