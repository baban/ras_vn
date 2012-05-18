# encoding: utf-8

class CreateEatStyles < ActiveRecord::Migration
  def change
    create_table :eat_styles do |t|
      t.string :name

      t.timestamps
    end
  end
end
