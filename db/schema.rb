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

ActiveRecord::Schema.define(:version => 20120512054405) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true

  create_table "area_masters", :force => true do |t|
    t.integer  "parent_id",  :null => false
    t.string   "name",       :null => false
    t.integer  "data_type",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "shop_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "food_genre_masters", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "data_type",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memus", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.integer  "price",      :default => 0,  :null => false
    t.text     "comment"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id",    :default => 0,   :null => false
    t.text     "comment"
    t.float    "point",      :default => 0.0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "search_logs", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "words",      :default => "", :null => false
    t.string   "location",   :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "shop_accesses", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_character_masters", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "data_type",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_sub_data", :force => true do |t|
    t.binary   "top_photo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shops", :force => true do |t|
    t.string   "name",              :null => false
    t.string   "sub_name",          :null => false
    t.boolean  "coupon_flg",        :null => false
    t.boolean  "mobile_coupon_flg", :null => false
    t.text     "comment",           :null => false
    t.float    "longitude"
    t.float    "latitude"
    t.string   "address"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email"
    t.string   "homepage"
    t.time     "open_time"
    t.time     "close_time"
    t.string   "close_day"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "user_infos", :force => true do |t|
    t.integer  "user_id"
    t.string   "nickname",      :default => "", :null => false
    t.boolean  "sex"
    t.integer  "blood_type"
    t.datetime "birthday"
    t.string   "mail_address"
    t.string   "postcode",      :default => "", :null => false
    t.string   "address",       :default => "", :null => false
    t.integer  "address_point"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
