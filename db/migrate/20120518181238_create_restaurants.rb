# encoding: utf-8

class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string   :name,              null: false
      t.string   :public,            null: false, default: false
      t.string   :sub_name,          null: false
      t.boolean  :coupon_flg,        null: false
      t.boolean  :mobile_coupon_flg, null: false
      t.text     :comment,           null: false, default: ""
      t.string   :postcode,          null: true
      t.string   :address,           null: true
      t.string   :phone_number,      null: true
      t.string   :fax_number,        null: true
      t.string   :email,             null: true
      t.string   :homepage,          null: true
      t.time     :open_time,         null: true
      t.time     :close_time,        null: true
      t.string   :close_day,         null: true

      t.time     :deleted_at,        null: true
      t.timestamps
    end
  end
end
