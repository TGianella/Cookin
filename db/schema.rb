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

ActiveRecord::Schema[7.0].define(version: 2023_03_27_090611) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "masterclasses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "duration"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chef_id"
    t.index ["chef_id"], name: "index_masterclasses_on_chef_id"
  end

  create_table "masterclasses_recipes", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "masterclass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["masterclass_id"], name: "index_masterclasses_recipes_on_masterclass_id"
    t.index ["recipe_id"], name: "index_masterclasses_recipes_on_recipe_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "masterclass_id"
    t.datetime "start_date"
    t.string "zip_code"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["masterclass_id"], name: "index_meetings_on_masterclass_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "duration"
    t.string "difficulty"
    t.bigint "chef_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chef_id"], name: "index_recipes_on_chef_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id"
    t.bigint "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
    t.index ["meeting_id"], name: "index_reservations_on_meeting_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "city"
    t.string "first_name"
    t.string "last_name"
    t.datetime "birth_date"
    t.string "zip_code"
    t.string "phone_number"
    t.boolean "is_admin", default: false, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_chef", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
