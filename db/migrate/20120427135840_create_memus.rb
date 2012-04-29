# encoding: utf-8

class CreateMemus < ActiveRecord::Migration
  def change
    create_table :memus do |t|
      t.string  :name,    null: false, default: ""
      t.integer :price,   null: false, default: 0
      t.text    :comment, null: true

      t.timestamps
    end
  end
end
