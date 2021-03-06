# encoding: utf-8

class CreateRecipeStepDrafts < ActiveRecord::Migration
  def change
    create_table :recipe_step_drafts do |t|
      t.integer  :recipe_draft_id,  null: false
      t.string   :image,      null: true
      t.string   :movie_url,  null: true
      t.string   :content,    null: false, default: ''
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end
