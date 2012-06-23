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

ActiveRecord::Schema.define(:version => 20120618145939) do

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

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "recipe_id",  :null => false
    t.time     "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "distincts", :force => true do |t|
    t.integer  "prefecture_id", :null => false
    t.string   "name",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "eat_styles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "food_genres", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "information", :force => true do |t|
    t.string   "title",      :default => "",    :null => false
    t.text     "content",                       :null => false
    t.boolean  "public",     :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "prefectures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_advertisements", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "url",        :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "recipe_comments", :force => true do |t|
    t.integer  "recipe_id",  :null => false
    t.integer  "user_id",    :null => false
    t.text     "content",    :null => false
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_food_genres", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_foods", :force => true do |t|
    t.integer  "recipe_food_genre_id", :null => false
    t.string   "name",                 :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "recipe_foodstuffs", :force => true do |t|
    t.integer  "recipe_id",                      :null => false
    t.integer  "recipe_food_id"
    t.string   "name",           :default => "", :null => false
    t.string   "amount",         :default => "", :null => false
    t.time     "deleted_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "recipe_like_logs", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_rankings", :force => true do |t|
    t.integer  "recipe_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_steps", :force => true do |t|
    t.integer  "recipe_id",                  :null => false
    t.string   "image"
    t.string   "content",    :default => "", :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "recipes", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.string   "title",        :default => "",    :null => false
    t.text     "description",                     :null => false
    t.boolean  "public",       :default => false, :null => false
    t.string   "recipe_image"
    t.text     "one_point",                       :null => false
    t.integer  "like_count",   :default => 0,     :null => false
    t.time     "deleted_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "restaurant_comments", :force => true do |t|
    t.integer  "restaurant_id",                    :null => false
    t.integer  "user_id",                          :null => false
    t.text     "comment"
    t.boolean  "public",        :default => false, :null => false
    t.float    "point",         :default => 0.0,   :null => false
    t.time     "deleted_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "restaurant_menus", :force => true do |t|
    t.integer  "restaurant_id",                 :null => false
    t.integer  "view_style",    :default => 1,  :null => false
    t.binary   "image"
    t.string   "title",         :default => "", :null => false
    t.text     "comment"
    t.text     "price_comment"
    t.text     "price"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "restaurant_profiles", :force => true do |t|
    t.integer  "restaurant_id", :null => false
    t.binary   "top_photo"
    t.float    "longitude"
    t.float    "latitude"
    t.time     "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "public",            :default => "0", :null => false
    t.string   "sub_name",                           :null => false
    t.boolean  "coupon_flg",                         :null => false
    t.boolean  "mobile_coupon_flg",                  :null => false
    t.text     "comment",                            :null => false
    t.string   "postcode"
    t.string   "address"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email"
    t.string   "homepage"
    t.time     "open_time"
    t.time     "close_time"
    t.string   "close_day"
    t.time     "deleted_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "search_logs", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "words",      :default => "", :null => false
    t.string   "location",   :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "tpl_sets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_profile_visibilities", :force => true do |t|
    t.integer  "user_profile_id", :default => 1
    t.boolean  "nickname",        :default => true, :null => false
    t.boolean  "sex",             :default => true, :null => false
    t.boolean  "first_name",      :default => true
    t.boolean  "last_name",       :default => true
    t.boolean  "blood_type",      :default => true, :null => false
    t.boolean  "birthday",        :default => true, :null => false
    t.boolean  "mail_address",    :default => true, :null => false
    t.boolean  "postcode",        :default => true, :null => false
    t.boolean  "address",         :default => true, :null => false
    t.boolean  "address_point",   :default => true, :null => false
    t.boolean  "comment",         :default => true, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.string   "nickname",     :default => "", :null => false
    t.integer  "sex"
    t.string   "first_name",   :default => ""
    t.string   "last_name",    :default => ""
    t.integer  "blood_type"
    t.date     "birthday"
    t.string   "mail_address"
    t.string   "postcode",     :default => "", :null => false
    t.string   "address",      :default => "", :null => false
    t.text     "comment",                      :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
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
    t.integer  "uid"
    t.string   "screen_name"
    t.string   "access_token"
    t.string   "access_secret"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
