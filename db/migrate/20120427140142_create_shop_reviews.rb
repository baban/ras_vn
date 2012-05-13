# encoding: utf-8

class CreateShopReviews < ActiveRecord::Migration
  def change
    create_table :shop_reviews do |t|
      t.integer :shop_id,     null: false
      t.integer :user_id,     null: false
      t.text    :comment,     null: true
      t.boolean :public,      null: false, default: false
      t.float   :point,       null: false, default: 0

      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
