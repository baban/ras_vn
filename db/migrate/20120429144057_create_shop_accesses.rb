# encoding: utf-8

class CreateShopAccesses < ActiveRecord::Migration
  def change
    create_table :shop_accesses do |t|

      t.timestamps
    end
  end
end
