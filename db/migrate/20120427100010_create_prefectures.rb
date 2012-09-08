# encoding: utf-8

class CreatePrefectures < ActiveRecord::Migration
  def change
    create_table :prefectures do |t|
      t.string  :name,   null: false
      t.boolean :public, null: false, default: true
      t.timestamps
    end
  end
end
