# encoding: utf-8

class AddIndexRecipeRankings < ActiveRecord::Migration
  def up
    add_index :recipe_rankings, :recipe_id
  end

  def down
    remove_index :recipe_rankings, :recipe_id
  end
end
