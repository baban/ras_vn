# encoding: utf-8

class CreateRecipeFoods < ActiveRecord::Migration
  def change
    create_table :recipe_foods do |t|
      t.integer :recipe_food_genre_id, null: false
      t.string  :name,                 null: false

      t.timestamps
    end
  end
end
