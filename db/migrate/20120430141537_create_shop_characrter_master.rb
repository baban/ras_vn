# encoding: utf-8

class CreateShopCharacrterMaster < ActiveRecord::Migration
  def change
    create_table :shop_character_masters do |t|
      t.string :name, null: false
      t.integer :data_type, null: false
      t.timestamps
    end
  end
end
