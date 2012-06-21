# encoding: utf-8

class CreateRecipeComments < ActiveRecord::Migration
  def change
    create_table :recipe_comments do |t|
      t.integer :recipe_id, null: false
      t.integer :user_id,   null: false
      t.text    :content,   null: false, default:""
      t.string  :image,     null: true
      t.timestamps
    end
  end
end
