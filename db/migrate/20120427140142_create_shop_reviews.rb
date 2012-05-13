# encoding: utf-8

class CreateShopReviews < ActiveRecord::Migration
  def change
    create_table :shop_reviews do |t|
      t.integer :shop_id, null: false
      t.integer :user_id, null: false
      t.text    :comment, null: true
      t.float   :point,   null: false, default: 0

      t.timestamps
    end
  end
end
