# encoding: utf-8

class CreateRestaurantMenus < ActiveRecord::Migration
  def change
    create_table :restaurant_menus do |t|
      t.integer :restaurant_id, null: false
      t.integer :view_style,    null: false, default: 1
      t.binary  :image,         null: true
      t.string  :title,         null: false, default: ""
      t.text    :comment,       null: true
      t.text    :price_comment, null: true
      t.text    :price,         null: true

      t.timestamps
    end
  end
end
