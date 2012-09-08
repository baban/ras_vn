# encoding: utf-8

class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.integer :user_id,  null: false
      t.string  :words,    null: false, default: ""
      t.string  :location, null: false, default: ""

      t.timestamps
    end
  end
end
