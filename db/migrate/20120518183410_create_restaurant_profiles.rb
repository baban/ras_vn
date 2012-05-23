# encoding: utf-8

class CreateRestaurantProfiles < ActiveRecord::Migration
  def change
    create_table :restaurant_profiles do |t|
      t.integer :restaurant_id, null: false
      t.binary  :top_photo,     null: true
      t.float   :longitude,     null: true
      t.float   :latitude,      null: true

      t.time   :deleted_at,     null: true
      t.timestamps
    end
  end
end
