# encoding: utf-8

class AddIndexRecipeLoveLogs < ActiveRecord::Migration
  def up
    add_index :recipe_love_logs, :user_id
    add_index :recipe_love_logs, :recipe_id
  end

  def down
    remove_index :recipe_love_logs, :user_id
    remove_index :recipe_love_logs, :recipe_id
  end
end
