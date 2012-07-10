# encoding: utf-8

class CreateRecipeFoodGenreRankings < ActiveRecord::Migration
  def change
    create_table :recipe_food_genre_rankings do |t|
      t.integer :recipe_food_genre_id
      t.integer :point, null: false, default: 0
      t.timestamps
    end
  end
end
