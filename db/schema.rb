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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", primary_key: "isbn13", force: :cascade do |t|
    t.text    "title"
    t.text    "format"
    t.text    "publisher"
    t.integer "year_of_publication"
    t.integer "copies"
    t.text    "keywords"
    t.text    "subject"
    t.decimal "price"
    t.text    "authors"
  end

  create_table "customers", primary_key: "login_id", force: :cascade do |t|
    t.text    "name"
    t.integer "mobile"
    t.text    "address"
    t.text    "cc_no"
  end

  create_table "orders", force: :cascade do |t|
    t.text    "customer_id", null: false
    t.text    "book_id",     null: false
    t.integer "copies"
    t.date    "order_date"
    t.text    "status"
  end

  create_table "review_ratings", id: false, force: :cascade do |t|
    t.text    "customer_id1", null: false
    t.text    "book_id",      null: false
    t.text    "customer_id2", null: false
    t.integer "rating"
  end

  create_table "reviews", id: false, force: :cascade do |t|
    t.text    "customer_id", null: false
    t.text    "book_id",     null: false
    t.integer "score",       null: false
    t.text    "comment"
  end

  create_table "store_managers", primary_key: "login_id", force: :cascade do |t|
  end

  create_table "users", primary_key: "login_id", force: :cascade do |t|
    t.text "password", null: false
  end

  add_foreign_key "customers", "users", column: "login_id", primary_key: "login_id", name: "customers_login_id_fkey"
  add_foreign_key "orders", "books", primary_key: "isbn13", name: "orders_book_id_fkey"
  add_foreign_key "orders", "customers", primary_key: "login_id", name: "orders_customer_id_fkey"
  add_foreign_key "review_ratings", "customers", column: "customer_id1", primary_key: "login_id", name: "review_ratings_customer_id1_fkey"
  add_foreign_key "review_ratings", "reviews", column: "customer_id2", primary_key: "customer_id", name: "review_ratings_customer_id2_fkey"
  add_foreign_key "reviews", "books", primary_key: "isbn13", name: "reviews_book_id_fkey"
  add_foreign_key "reviews", "customers", primary_key: "login_id", name: "reviews_customer_id_fkey"
  add_foreign_key "store_managers", "users", column: "login_id", primary_key: "login_id", name: "store_managers_login_id_fkey"
end
