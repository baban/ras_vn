# encoding: utf-8

class AddIndexRecipeComments < ActiveRecord::Migration
  def up
    add_index :recipe_comments, :user_id
    add_index :recipe_comments, :recipe_id
  end

  def down
    remove_index :recipe_comments, :user_id
    remove_index :recipe_comments, :recipe_id
  end
end
