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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120430114708) do

  create_table "archived_navs", :force => true do |t|
    t.date    "date"
    t.float   "nav"
    t.integer "fund_id"
  end

  create_table "assets", :force => true do |t|
    t.float   "quantity_purchased"
    t.float   "book_value"
    t.date    "purchase_date"
    t.integer "user_id"
    t.integer "fund_id"
  end

  create_table "funds", :force => true do |t|
    t.string "name"
    t.string "fund_type"
    t.float  "nav"
    t.date   "last_updated_date"
  end

  create_table "users", :force => true do |t|
    t.string "name"
    t.string "email"
  end

end
