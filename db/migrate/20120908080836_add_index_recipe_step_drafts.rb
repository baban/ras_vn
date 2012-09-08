# encoding: utf-8

class AddIndexRecipeStepDrafts < ActiveRecord::Migration
  def up
    add_index :recipe_step_drafts, :recipe_draft_id
  end

  def down
    remove_index :recipe_step_drafts, :recipe_draft_id
  end
end
