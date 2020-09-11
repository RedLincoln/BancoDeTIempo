# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_11_004807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "supcategory"
    t.index ["name", "supcategory"], name: "index_categories_on_name_and_supcategory", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_petition_id"
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["service_petition_id"], name: "index_messages_on_service_petition_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.string "target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "seen", default: false
    t.string "link"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.text "addition_information"
    t.bigint "service_id"
    t.bigint "client_id"
    t.string "status", default: "Negociación"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.datetime "datetime"
    t.index ["client_id", "service_id"], name: "index_transactions_on_client_id_and_service_id", unique: true
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["service_id"], name: "index_transactions_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.text "introduction"
    t.string "picture"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "standard"
    t.integer "balance", default: 5
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "messages", "transactions", column: "service_petition_id"
  add_foreign_key "messages", "users", column: "author_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "services", "categories"
  add_foreign_key "transactions", "users", column: "client_id"
end
