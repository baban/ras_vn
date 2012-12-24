# encoding: utf-8

class AddColumnCaloryToFoodstuff < ActiveRecord::Migration
  def up
    add_column    :recipe_foodstuffs, :calory, :integer, null: true
  end
  def down
    remove_column :recipe_foodstuffs, :calory
  end
end
