# encoding: utf-8

class ChangeColumnRecipeStepDraftContent < ActiveRecord::Migration
  def up
    change_column :recipe_step_drafts, :content, :text
  end

  def down
    change_column :recipe_step_drafts, :content, :string
  end
end
