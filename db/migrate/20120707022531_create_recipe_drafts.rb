# encoding: utf-8

class CreateRecipeDrafts < ActiveRecord::Migration
  def change
    create_table :recipe_drafts do |t|
      t.integer  :user_id,        null: false
      t.integer  :recipe_id,      null: false
      t.string   :title,          null: false, default: ''
      t.text     :description,    null: false, default: ''
      t.boolean  :public,         null: false, default: false
      t.string   :recipe_image,   null: true
      t.text     :one_point,      null: false, default: ''
      t.integer  :love_count,     null: false, default: 0
      t.integer  :eatstyle_id,    null: false, default: 0
      t.integer  :amount,         null: true
      t.integer  :view_count,     null: false, default: 0
      t.integer  :recipe_food_id, null: true

      t.time     :del_flg,        null: false, default: 0
      t.timestamps
    end
  end
end
