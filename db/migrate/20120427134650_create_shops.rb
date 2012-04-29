
# encoding: utf-8

class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string  :name,         null: false
      t.integer :point,        null: true,  default: 0
      t.text    :comment,      null: false, default: ""
      t.float   :longitude,    null: true
      t.float   :latitude,     null: true
      t.string  :address,      null: true
      t.string  :phone_number, null: true
      t.string  :fax_number,   null: true
      t.string  :email,        null: true
      t.string  :homepage,     null: true
      t.time    :open_time,    null: true
      t.time    :close_time,   null: true
      t.string  :close_day,    null: true
      t.timestamps
    end
  end
end
