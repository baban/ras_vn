# encoding: utf-8

class CreateRecipeSteps < ActiveRecord::Migration
  def change
    create_table :recipe_steps do |t|
      t.integer  :recipe_id,  null: false
      t.string   :context,    null: false, default: ''
      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
