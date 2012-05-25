# encoding: utf-8

class CreateRecipeRankings < ActiveRecord::Migration
  def change
    create_table :recipe_rankings do |t|
      t.integer :recipe_id, null: false
      t.timestamps
    end
  end
end
