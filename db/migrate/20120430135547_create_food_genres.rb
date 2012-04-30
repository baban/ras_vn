# encoding: utf-8

class CreateFoodGenreMaster < ActiveRecord::Migration
  def change
    create_table :food_genre_masters do |t|
      t.string :name
      t.timestamps
    end
  end
end
