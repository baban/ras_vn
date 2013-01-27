# encoding: utf-8

class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.string :words, null: false, default: ""

      t.timestamps
    end
  end
end
