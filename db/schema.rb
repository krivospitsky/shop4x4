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

ActiveRecord::Schema.define(version: 20150124141859) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.integer  "variant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id"
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "parent_id"
    t.string   "image",       limit: 255
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
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "cart_id"
    t.string   "state",      limit: 255
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "zip",        limit: 255
    t.string   "city",       limit: 255
    t.string   "address",    limit: 255
    t.string   "comment",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secure_key"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "text"
    t.string   "image",      limit: 255
    t.boolean  "enabled"
    t.integer  "sort_order"
    t.string   "position",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "options",     limit: 255
    t.text     "description"
    t.integer  "price"
    t.string   "sku",         limit: 255
    t.integer  "count"
    t.boolean  "enabled"
    t.integer  "sort_order"
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
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "sort_order"
    t.boolean  "enabled"
    t.boolean  "has_banner"
    t.string   "banner",      limit: 255
    t.boolean  "send_mail"
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seos", force: :cascade do |t|
    t.integer  "seoable_id"
    t.string   "seoable_type", limit: 255
    t.string   "title",        limit: 255
    t.text     "keywords"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 255, null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "variants", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name",       limit: 255
    t.string   "sku",        limit: 255
    t.integer  "price"
    t.integer  "count"
    t.boolean  "enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
