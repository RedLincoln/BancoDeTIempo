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

ActiveRecord::Schema.define(version: 2020_10_30_032707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "supcategory"
    t.index ["name", "supcategory"], name: "index_categories_on_name_and_supcategory", unique: true
  end

  create_table "chat_room_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chat_room_id"
    t.boolean "closed", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "last_message"
    t.integer "message_not_read_count", default: 0
    t.index ["chat_room_id"], name: "index_chat_room_users_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_room_users_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message_type", default: "text"
    t.jsonb "changes_made", default: "{}", null: false
    t.bigint "chat_room_id"
    t.index ["author_id"], name: "index_messages_on_author_id"
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.string "target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "seen", default: false
    t.string "link"
    t.string "scope", default: ""
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.bigint "transaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "message"
    t.decimal "rating"
    t.index ["transaction_id"], name: "index_rates_on_transaction_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.string "service_type", default: "offer"
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "services_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "service_id"
    t.index ["service_id"], name: "index_services_tags_on_service_id"
    t.index ["tag_id"], name: "index_services_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "service_id"
    t.bigint "client_id"
    t.string "status", default: "Negociación"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration"
    t.datetime "datetime"
    t.text "additional_information"
    t.bigint "client_rate_id"
    t.bigint "owner_rate_id"
    t.index ["client_id", "service_id"], name: "index_transactions_on_client_id_and_service_id", unique: true
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["client_rate_id"], name: "index_transactions_on_client_rate_id"
    t.index ["owner_rate_id"], name: "index_transactions_on_owner_rate_id"
    t.index ["service_id"], name: "index_transactions_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "standard"
    t.integer "balance", default: 5
    t.text "information"
    t.boolean "confirmed", default: false
    t.boolean "blocked", default: false
    t.string "telephone"
    t.boolean "telephone_visible", default: true
    t.boolean "email_visible", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chat_room_users", "chat_rooms"
  add_foreign_key "chat_room_users", "users"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users", column: "author_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "rates", "transactions"
  add_foreign_key "services", "categories"
  add_foreign_key "transactions", "rates", column: "client_rate_id"
  add_foreign_key "transactions", "rates", column: "owner_rate_id"
  add_foreign_key "transactions", "users", column: "client_id"
end
