# encoding: utf-8

class CreateRecipeAdvertisements < ActiveRecord::Migration
  def change
    create_table :recipe_advertisements do |t|
      t.string :name,  null: false
      t.string :url,   null: false, default: ""
      t.string :image, null: true
      t.string :alt,   null: true

      t.timestamps
    end
  end
end
