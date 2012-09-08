# encoding: utf-8

class AddIndexToppageContents < ActiveRecord::Migration
  def up
    add_index :toppage_contents, :recommend_recipe_id
  end

  def down
    remove_index :toppage_contents, :recommend_recipe_id
  end
end
