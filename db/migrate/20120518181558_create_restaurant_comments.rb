# encoding: utf-8

class CreateRestaurantComments < ActiveRecord::Migration
  def change
    create_table :restaurant_comments do |t|
      t.integer :restaurant_id, null: false
      t.integer :user_id,     null: false
      t.text    :comment,     null: true
      t.boolean :public,      null: false, default: false
      t.float   :point,       null: false, default: 0

      t.time    :deleted_at, null: true
      t.timestamps
    end
  end
end
