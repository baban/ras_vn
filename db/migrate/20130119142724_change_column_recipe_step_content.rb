# encoding: utf-8

class ChangeColumnRecipeStepContent < ActiveRecord::Migration
  def up
    change_column :recipe_steps, :content, :text
  end

  def down
    change_column :recipe_steps, :content, :text
  end
end
