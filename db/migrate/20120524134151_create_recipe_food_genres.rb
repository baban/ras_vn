# encoding: utf-8

class CreateRecipeFoodGenres < ActiveRecord::Migration
  def change
    create_table :recipe_food_genres do |t|
      t.string  :name,   null: false
      t.string  :image,  null: true
      t.integer :amount, null: false, default: 0
      t.timestamps
    end
  end
end
