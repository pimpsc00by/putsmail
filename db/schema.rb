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

ActiveRecord::Schema.define(:version => 20120329150812) do

  create_table "properties", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_mail_users", :force => true do |t|
    t.integer  "test_mail_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",       :default => true
  end

  create_table "test_mails", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
    t.text     "body"
    t.string   "token"
    t.integer  "sent_count", :default => 0
  end

  add_index "test_mails", ["token"], :name => "index_test_mails_on_token", :unique => true

  create_table "users", :force => true do |t|
    t.string   "mail",       :null => false
    t.string   "token",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "subscribed"
  end

end
