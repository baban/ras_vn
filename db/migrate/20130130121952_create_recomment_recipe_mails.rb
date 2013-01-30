# encoding: utf-8

class CreateRecommentRecipeMails < ActiveRecord::Migration
  def change
    create_table :recomment_recipe_mails do |t|
      t.date    :day,       null: false
      t.integer :recipe_id, null: false

      t.timestamps
    end
  end
end
