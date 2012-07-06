# encoding: utf-8

class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.integer  :user_id,     null: false
      t.string   :title,       null: false, default: ""
      t.text     :content,     null: false, default: ""
      t.integer  :category_id, null: false, default: 0
      t.boolean  :public,      null: false, default: true
      t.datetime :deleted_at,  null: true

      t.timestamps
    end
  end
end
