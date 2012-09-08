# encoding: utf-8

class AddIndexRecipeFoodstuffDrafts < ActiveRecord::Migration
  def up
    add_index :recipe_foodstuff_drafts, :recipe_draft_id
  end

  def down
    remove_index :recipe_foodstuff_drafts, :recipe_draft_id
  end
end
