# encoding: utf-8
class AddIndexRecipes < ActiveRecord::Migration
  def up
    add_index :recipes, :user_id
  end

  def down
    remove_index :recipes, :user_id
  end
end
