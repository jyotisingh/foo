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

ActiveRecord::Schema.define(:version => 20120427130459) do

  create_table "funds", :force => true do |t|
    t.string "name"
    t.string "type"
    t.float  "nav"
    t.date   "last_updated_date"
  end

  create_table "holders", :force => true do |t|
    t.string "name"
  end

  create_table "investments", :force => true do |t|
    t.float "quantity_purchased"
    t.float "investment_amount"
  end

end
