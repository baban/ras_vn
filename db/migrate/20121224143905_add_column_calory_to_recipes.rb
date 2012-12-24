# encoding: utf-8

class AddColumnCaloryToRecipes < ActiveRecord::Migration
  def up
    add_column    :recipes, :calory, :integer, null: true
  end
  def down
    remove_column :recipes, :calory
  end
end
