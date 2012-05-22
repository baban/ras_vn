# encoding: utf-8

class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string  :title,   null: false, default: ''
      t.text    :content, null: false, default: ''
      t.boolean :public,  null: false, default: false
      t.timestamps
    end
  end
end
