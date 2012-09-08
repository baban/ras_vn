# encoding: utf-8

class AddIndexRecipeDrafts < ActiveRecord::Migration
  def up
    add_index :recipe_drafts, :user_id
  end

  def down
    remove_index :recipe_drafts, :user_id
  end
end
