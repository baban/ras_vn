# encoding: utf-8

class AddColumnCaloryToRecipeDrafts < ActiveRecord::Migration
  def up
    add_column    :recipe_drafts, :calory, :integer, null: true
  end
  def down
    remove_column :recipe_drafts, :calory
  end
end
