# encoding: utf-8

class CreateRestaurantMenus < ActiveRecord::Migration
  def change
    create_table :restaurant_menus do |t|
      t.integer :restaurant_id, null: false
      t.string  :name,          null: false, default: ""
      t.integer :price,         null: false, default: 0
      t.text    :comment,       null: true

      t.timestamps
    end
  end
end
