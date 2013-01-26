# encoding: utf-8

class CreateRecipeViewLogs < ActiveRecord::Migration
  def change
    create_table :recipe_view_logs do |t|
      t.integer :recipe_id, null: false

      t.timestamps
    end
  end
end
