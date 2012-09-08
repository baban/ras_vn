# encoding: utf-8

class AddIndexRecipeFoodGenreRankings < ActiveRecord::Migration
  def up
    add_index :recipe_food_genre_rankings, :recipe_food_genre_id
  end

  def down
    remove_index :recipe_food_genre_rankings, :recipe_food_genre_id
  end
end
