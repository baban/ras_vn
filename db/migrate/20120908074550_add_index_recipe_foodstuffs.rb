# encoding: utf-8

class AddIndexRecipeFoodstuffs < ActiveRecord::Migration
  def up
    add_index :recipe_foodstuffs, :recipe_id
  end

  def down
    remove_index :recipe_foodstuffs, :recipe_id
  end
end
