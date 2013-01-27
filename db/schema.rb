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

ActiveRecord::Schema.define(:version => 20130126073900) do

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

  create_table "affiriate_logs", :force => true do |t|
    t.string   "session_id",     :null => false
    t.string   "affiriate_code", :null => false
    t.integer  "affiriate_type", :null => false
    t.integer  "user_id"
    t.datetime "completed_at"
    t.datetime "retired_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "affiriate_logs", ["session_id"], :name => "index_affiriate_logs_on_session_id"
  add_index "affiriate_logs", ["user_id"], :name => "index_affiriate_logs_on_user_id"

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "recipe_id",                 :null => false
    t.integer  "del_flg",    :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "bookmarks", ["recipe_id"], :name => "index_bookmarks_on_recipe_id"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "diaries", :force => true do |t|
    t.integer  "user_id",                                        :null => false
    t.string   "title",       :default => "",                    :null => false
    t.text     "content",                                        :null => false
    t.integer  "category_id", :default => 0,                     :null => false
    t.string   "image"
    t.datetime "publiced_at", :default => '2012-11-17 00:00:00', :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "diaries", ["user_id"], :name => "index_diaries_on_user_id"

  create_table "distincts", :force => true do |t|
    t.integer  "prefecture_id",                   :null => false
    t.string   "name",                            :null => false
    t.boolean  "public",        :default => true, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "distincts", ["prefecture_id"], :name => "index_distincts_on_prefecture_id"

  create_table "eat_styles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entret_logs", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "status",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entret_results", :force => true do |t|
    t.date     "day",                         :null => false
    t.integer  "entry",        :default => 0, :null => false
    t.integer  "retire",       :default => 0, :null => false
    t.integer  "entret",       :default => 0, :null => false
    t.integer  "entry_total",  :default => 0, :null => false
    t.integer  "retire_total", :default => 0, :null => false
    t.integer  "active_total", :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "facebook_friend_invites", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.string   "invite_user_id",                :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "status",         :default => 0, :null => false
    t.datetime "completed_at"
  end

  create_table "fail_mails", :force => true do |t|
    t.string   "email",                     :null => false
    t.integer  "count",      :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "followers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "deleted_at"
  end

  create_table "food_calories", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "calory",     :default => 0, :null => false
    t.integer  "amount",     :default => 0, :null => false
    t.string   "unit",                      :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
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

  create_table "mail_buffers", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "from",                       :null => false
    t.string   "reply_to",                   :null => false
    t.string   "bcc",                        :null => false
    t.string   "subject",    :default => "", :null => false
    t.text     "body",                       :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "mail_templates", :force => true do |t|
    t.string   "title",      :default => "",    :null => false
    t.text     "content",                       :null => false
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.string   "from",                          :null => false
    t.string   "reply_to",                      :null => false
    t.string   "bcc",                           :null => false
    t.boolean  "public",     :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "newsfeeds", :force => true do |t|
    t.string   "title",      :default => "",   :null => false
    t.text     "content",                      :null => false
    t.string   "image"
    t.boolean  "public",     :default => true, :null => false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "omniusers", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prefectures", :force => true do |t|
    t.string   "name",                         :null => false
    t.boolean  "public",     :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "recipe_advertisements", :force => true do |t|
    t.string   "name",                       :null => false
    t.string   "url",        :default => "", :null => false
    t.string   "image"
    t.string   "alt"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "recipe_comments", :force => true do |t|
    t.integer  "recipe_id",                  :null => false
    t.integer  "user_id",                    :null => false
    t.string   "title",      :default => "", :null => false
    t.text     "content",                    :null => false
    t.string   "image"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "deleted_at"
  end

  add_index "recipe_comments", ["recipe_id"], :name => "index_recipe_comments_on_recipe_id"
  add_index "recipe_comments", ["user_id"], :name => "index_recipe_comments_on_user_id"

  create_table "recipe_drafts", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "recipe_id",                         :null => false
    t.string   "title",          :default => "",    :null => false
    t.text     "description",                       :null => false
    t.boolean  "public",         :default => false, :null => false
    t.string   "recipe_image"
    t.text     "one_point",                         :null => false
    t.integer  "love_count",     :default => 0,     :null => false
    t.integer  "eatstyle_id",    :default => 0,     :null => false
    t.integer  "amount"
    t.integer  "view_count",     :default => 0,     :null => false
    t.integer  "recipe_food_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "calory"
  end

  add_index "recipe_drafts", ["user_id"], :name => "index_recipe_drafts_on_user_id"

  create_table "recipe_food_genre_rankings", :force => true do |t|
    t.integer  "recipe_food_genre_id",                           :null => false
    t.integer  "point",                :default => 0,            :null => false
    t.date     "ranked_at",            :default => '2012-11-17', :null => false
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "recipe_food_genre_rankings", ["recipe_food_genre_id"], :name => "index_recipe_food_genre_rankings_on_recipe_food_genre_id"

  create_table "recipe_food_genres", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "image"
    t.integer  "amount",     :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "recipe_foods", :force => true do |t|
    t.integer  "recipe_food_genre_id",                    :null => false
    t.string   "name",                                    :null => false
    t.boolean  "show_top",             :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "recipe_foodstuff_drafts", :force => true do |t|
    t.integer  "recipe_draft_id",                 :null => false
    t.integer  "recipe_food_id"
    t.string   "name",            :default => "", :null => false
    t.string   "amount",          :default => "", :null => false
    t.time     "deleted_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "calory"
  end

  add_index "recipe_foodstuff_drafts", ["recipe_draft_id"], :name => "index_recipe_foodstuff_drafts_on_recipe_draft_id"

  create_table "recipe_foodstuffs", :force => true do |t|
    t.integer  "recipe_id",                      :null => false
    t.integer  "recipe_food_id"
    t.string   "name",           :default => "", :null => false
    t.string   "amount",         :default => "", :null => false
    t.time     "deleted_at"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "calory"
  end

  add_index "recipe_foodstuffs", ["recipe_id"], :name => "index_recipe_foodstuffs_on_recipe_id"

  create_table "recipe_love_logs", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "recipe_love_logs", ["recipe_id"], :name => "index_recipe_love_logs_on_recipe_id"
  add_index "recipe_love_logs", ["user_id"], :name => "index_recipe_love_logs_on_user_id"

  create_table "recipe_rankings", :force => true do |t|
    t.integer  "recipe_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "recipe_rankings", ["recipe_id"], :name => "index_recipe_rankings_on_recipe_id"

  create_table "recipe_step_drafts", :force => true do |t|
    t.integer  "recipe_draft_id", :null => false
    t.string   "image"
    t.string   "movie_url"
    t.text     "content",         :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "recipe_step_drafts", ["recipe_draft_id"], :name => "index_recipe_step_drafts_on_recipe_draft_id"

  create_table "recipe_steps", :force => true do |t|
    t.integer  "recipe_id",  :null => false
    t.string   "image"
    t.string   "movie_url"
    t.text     "content",    :null => false
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "recipe_steps", ["recipe_id"], :name => "index_recipe_steps_on_recipe_id"

  create_table "recipe_view_logs", :force => true do |t|
    t.integer  "recipe_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipes", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.string   "title",          :default => "",    :null => false
    t.text     "description",                       :null => false
    t.boolean  "public",         :default => false, :null => false
    t.string   "recipe_image"
    t.text     "one_point",                         :null => false
    t.integer  "love_count",     :default => 0,     :null => false
    t.integer  "eatstyle_id",    :default => 0,     :null => false
    t.integer  "amount"
    t.integer  "view_count",     :default => 0,     :null => false
    t.integer  "recipe_food_id"
    t.time     "deleted_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "calory"
    t.integer  "status",         :default => 0,     :null => false
  end

  add_index "recipes", ["user_id"], :name => "index_recipes_on_user_id"

  create_table "search_logs", :force => true do |t|
    t.string   "words",      :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "streams", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "stream_type", :null => false
    t.text     "title",       :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "toppage_contents", :force => true do |t|
    t.integer  "recommend_recipe_id",       :null => false
    t.integer  "recommend_recipe_genre_id", :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "toppage_contents", ["recommend_recipe_id"], :name => "index_toppage_contents_on_recommend_recipe_id"

  create_table "tpl_sets", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "content",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tracker_logs", :force => true do |t|
    t.string   "session_id",   :null => false
    t.string   "tracker_code", :null => false
    t.datetime "limit_at"
    t.datetime "completed_at"
    t.string   "user_id"
    t.integer  "carrier"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tracker_results", :force => true do |t|
    t.date     "day",                         :null => false
    t.string   "tracker_code",                :null => false
    t.integer  "come",         :default => 0, :null => false
    t.integer  "entry",        :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "user_profile_visibilities", :force => true do |t|
    t.integer  "user_profile_id", :default => 1
    t.boolean  "nickname",        :default => true, :null => false
    t.boolean  "sex",             :default => true, :null => false
    t.boolean  "first_name",      :default => true
    t.boolean  "family_name",     :default => true
    t.boolean  "birthday",        :default => true, :null => false
    t.boolean  "email",           :default => true, :null => false
    t.boolean  "phone_number",    :default => true, :null => false
    t.boolean  "prefecture_id",   :default => true, :null => false
    t.boolean  "distinct_id",     :default => true, :null => false
    t.boolean  "comment",         :default => true, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.datetime "deleted_at"
  end

  add_index "user_profile_visibilities", ["user_profile_id"], :name => "index_user_profile_visibilities_on_user_profile_id"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.string   "nickname",      :default => "",   :null => false
    t.integer  "sex"
    t.string   "first_name",    :default => ""
    t.string   "family_name",   :default => ""
    t.date     "birthday"
    t.string   "email"
    t.string   "phone_number"
    t.integer  "prefecture_id", :default => 1,    :null => false
    t.integer  "distinct_id",   :default => 1,    :null => false
    t.text     "comment",                         :null => false
    t.integer  "recipe_count",  :default => 0,    :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "mail_status",   :default => true
    t.datetime "deleted_at"
  end

  add_index "user_profiles", ["user_id"], :name => "index_user_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "omniuser_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.datetime "deleted_at"
    t.boolean  "retire_flg",             :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
