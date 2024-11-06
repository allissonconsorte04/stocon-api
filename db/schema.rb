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

ActiveRecord::Schema.define(version: 2024_11_06_014700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "products_id"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_id"], name: "index_inventories_on_products_id"
    t.index ["users_id"], name: "index_inventories_on_users_id"
  end

  create_table "inventories_products", force: :cascade do |t|
    t.bigint "inventory_id"
    t.bigint "product_id"
    t.index ["inventory_id"], name: "index_inventories_products_on_inventory_id"
    t.index ["product_id"], name: "index_inventories_products_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.integer "quantity"
    t.bigint "category_id"
    t.string "measurement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id"
    t.string "code"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sale_items", force: :cascade do |t|
    t.bigint "sale_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sale_items_on_product_id"
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "sale_date"
    t.decimal "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sales_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "document"
    t.bigint "role_id"
    t.string "password_digest"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "inventories", "products", column: "products_id"
  add_foreign_key "inventories", "users", column: "users_id"
  add_foreign_key "inventories_products", "inventories"
  add_foreign_key "inventories_products", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "suppliers"
  add_foreign_key "sale_items", "products"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sales", "users"
  add_foreign_key "users", "roles"
end
