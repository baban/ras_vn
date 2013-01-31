# encoding: utf-8

class CreateRecommendRecipeMails < ActiveRecord::Migration
  def change
    create_table :recommend_recipe_mails do |t|
      t.date    :day,       null: false
      t.integer :recipe_id, null: false
      t.text    :news_text, null: true

      t.timestamps
    end
  end
end
