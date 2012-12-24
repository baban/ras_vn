# encoding: utf-8

class AddColumnCaloryToFoodstuffDraft < ActiveRecord::Migration
  def up
    add_column    :recipe_foodstuff_drafts, :calory, :integer, null: true
  end
  def down
    remove_column :recipe_foodstuff_drafts, :calory
  end
end
