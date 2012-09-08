# encoding: utf-8
class AddIndexRecipeSteps < ActiveRecord::Migration
  def up
    add_index :recipe_steps, :recipe_id
  end

  def down
    remove_index :recipe_steps, :recipe_id
  end
end
