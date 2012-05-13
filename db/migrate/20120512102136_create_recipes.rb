# encoding: utf-8

class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :user_id,     null: false
      t.string  :title,       null: false, default: ''
      t.text    :description, null: false, default: ''
      t.text    :one_point,   null: false, default: ''

      t.timestamps
    end
  end
end
