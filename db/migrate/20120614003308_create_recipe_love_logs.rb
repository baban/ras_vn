# encoding: utf-8

class CreateRecipeLoveLogs < ActiveRecord::Migration
  def change
    create_table :recipe_love_logs do |t|
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
