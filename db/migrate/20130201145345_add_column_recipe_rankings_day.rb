# encoding: utf-8

class AddColumnRecipeRankingsDay < ActiveRecord::Migration
  def up
    add_column    :recipe_rankings, :day, :date, null: true, default: Time.now
  end

  def down
    remove_column :recipe_rankings, :day
  end
end
