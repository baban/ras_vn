# encoding: utf-8

class CreateRestaurantProfiles < ActiveRecord::Migration
  def change
    create_table :restaurant_profiles do |t|
      t.binary :top_photo, null: true

      t.time   :deleted_at,        null: true
      t.timestamps
    end
  end
end
