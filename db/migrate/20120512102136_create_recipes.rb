# encoding: utf-8

class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer  :user_id,      null: false
      t.string   :title,        null: false, default: ''
      t.text     :description,  null: false, default: ''
      t.boolean  :public,       null: false, default: false
      t.string   :recipe_image, null: true
      t.text     :one_point,    null: false, default: ''

      t.time     :deleted_at,   null: true
      t.timestamps
    end
  end
end
