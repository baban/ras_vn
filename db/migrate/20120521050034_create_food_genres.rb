# encoding: utf-8

class CreateFoodGenres < ActiveRecord::Migration
  def change
    create_table :food_genres do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
