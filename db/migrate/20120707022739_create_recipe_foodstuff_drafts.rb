# encoding: utf-8

class CreateRecipeFoodstuffDrafts < ActiveRecord::Migration
  def change
    create_table :recipe_foodstuff_drafts do |t|
      t.integer :recipe_draft_id, null: false
      t.integer :recipe_food_id,  null: true
      t.string  :name,            null: false, default: ''
      t.string  :amount,          null: false, default: ''

      t.time    :deleted_at,      null: true

      t.timestamps
    end
  end
end
