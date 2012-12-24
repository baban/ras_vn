# encoding: utf-8

class CreateFoodCalories < ActiveRecord::Migration
  def change
    create_table :food_calories do |t|
      t.string  :name,   null: false
      t.integer :calory, null: false, default: 0
      t.integer :amount, null: false, default: 0
      t.string  :unit,   null: false
      t.timestamps
    end
  end
end
