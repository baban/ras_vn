# encoding: utf-8

class CreateShopCharacrterMasters < ActiveRecord::Migration
  def change
    create_table :shop_character_masters do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
