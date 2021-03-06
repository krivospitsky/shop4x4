# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150308114035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.integer  "variant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "image"
    t.boolean  "enabled"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_id"
  end

  create_table "categories_linked_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "linked_category_id"
  end

  create_table "categories_linked_products", force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "categories_products", force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "categories_promotions", force: :cascade do |t|
    t.integer "promotion_id"
    t.integer "category_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "description_images", force: :cascade do |t|
    t.string   "original_url"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "cart_id"
    t.string   "state"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "zip"
    t.string   "city"
    t.string   "address"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secure_key"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.text     "text"
    t.string   "image"
    t.boolean  "enabled"
    t.integer  "sort_order"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "sort_order"
    t.integer  "price"
    t.string   "sku"
    t.integer  "count"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attr"
  end

  create_table "products_linked_categories", force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
  end

  create_table "products_linked_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "linked_product_id"
  end

  create_table "products_promotions", force: :cascade do |t|
    t.integer "promotion_id"
    t.integer "product_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "sort_order"
    t.boolean  "enabled"
    t.boolean  "has_banner"
    t.string   "banner"
    t.boolean  "send_mail"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seos", force: :cascade do |t|
    t.integer  "seoable_id"
    t.string   "seoable_type"
    t.string   "title"
    t.text     "keywords"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "variants", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "sku"
    t.integer  "price"
    t.integer  "count"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attr"
    t.string   "image"
    t.string   "availability"
  end

end
