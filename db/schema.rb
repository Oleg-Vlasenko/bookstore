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

ActiveRecord::Schema.define(version: 20150618131816) do

  create_table "addresses", force: true do |t|
    t.string   "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "phone"
    t.text     "type"
    t.text     "first_name"
    t.text     "last_name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_id"
  end

  add_index "addresses", ["country_id"], name: "index_addresses_on_country_id"
  add_index "addresses", ["test_id"], name: "index_addresses_on_test_id"

  create_table "authors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.integer  "stock"
    t.integer  "author_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["author_id"], name: "index_books_on_author_id"
  add_index "books", ["category_id"], name: "index_books_on_category_id"

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_cards", force: true do |t|
    t.integer  "number"
    t.integer  "CVV"
    t.integer  "expiration_year"
    t.integer  "expiration_month"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_cards", ["customer_id"], name: "index_credit_cards_on_customer_id"

  create_table "customers", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_state"
    t.string   "cart_state"
  end

  add_index "customers", ["billing_address_id"], name: "index_customers_on_billing_address_id"
  add_index "customers", ["shipping_address_id"], name: "index_customers_on_shipping_address_id"

  create_table "order_items", force: true do |t|
    t.float    "price"
    t.integer  "quantity"
    t.float    "total_sum"
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_items", ["book_id"], name: "index_order_items_on_book_id"
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id"

  create_table "orders", force: true do |t|
    t.date     "completed_date"
    t.string   "state"
    t.integer  "shipping"
    t.integer  "customer_id"
    t.integer  "credit_card_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_id"
    t.integer  "one_address"
  end

  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id"
  add_index "orders", ["credit_card_id"], name: "index_orders_on_credit_card_id"
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id"
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
  add_index "orders", ["test_id"], name: "index_orders_on_test_id"

  create_table "reviews", force: true do |t|
    t.text     "title"
    t.text     "review_text"
    t.integer  "rating"
    t.integer  "book_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id"
  add_index "reviews", ["customer_id"], name: "index_reviews_on_customer_id"

  create_table "tests", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
