# encoding: utf-8

class CreateNewsfeeds < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.string   :title,    null: false, default: ""
      t.text     :content,  null: false, default: ""
      t.string   :image,    null: true
      t.boolean  :public,   null: false, default: true
      t.datetime :start_at, null: true
      t.datetime :end_at,   null: true

      t.timestamps
    end
  end
end
