# encoding: utf-8

class CreateRecipeAdvertisements < ActiveRecord::Migration
  def change
    create_table :recipe_advertisements do |t|
      t.string :name, null: false
      t.string :url,  null: false, default: ""

      t.timestamps
    end
  end
end
