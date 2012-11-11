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

ActiveRecord::Schema.define(:version => 20121112235706) do

  create_table "test_mail_users", :force => true do |t|
    t.integer  "test_mail_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",       :default => true
  end

  add_index "test_mail_users", ["test_mail_id"], :name => "index_test_mail_users_on_test_mail_id"
  add_index "test_mail_users", ["user_id"], :name => "index_test_mail_users_on_user_id"

  create_table "test_mails", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject"
    t.text     "body"
    t.string   "token"
    t.integer  "sent_count",      :default => 0
    t.boolean  "in_gallery",      :default => true
    t.boolean  "make_css_inline", :default => true
    t.integer  "user_id"
  end

  add_index "test_mails", ["token"], :name => "index_test_mails_on_token", :unique => true

  create_table "users", :force => true do |t|
    t.string   "mail",                               :null => false
    t.string   "token",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "subscribed",       :default => true
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "users", ["token"], :name => "index_users_on_token"

end
