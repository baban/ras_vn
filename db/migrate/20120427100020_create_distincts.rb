# encoding: utf-8

class CreateDistincts < ActiveRecord::Migration
  def change
    create_table :distincts do |t|
      t.integer :prefecture_id, null: false
      t.string  :name,          null: false
      t.boolean :public,        null: false, default: true

      t.timestamps
    end
  end
end
