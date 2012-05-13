# encoding: utf-8

class CreateShopSubData < ActiveRecord::Migration
  def change
    create_table :shop_sub_data do |t|
      t.binary :top_photo, null: true

      t.datetime :deleted_at,        null: true
      t.timestamps
    end
  end
end
