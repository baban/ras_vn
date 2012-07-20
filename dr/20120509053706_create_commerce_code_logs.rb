# encoding: utf-8

class CreateCommerceCodeLogs < ActiveRecord::Migration
  def change
    create_table :commerce_code_logs do |t|
      t.string   :session_id,     null: false
      t.string   :commerce_code,  null: false
      t.datetime :completeted_at, null: true
      t.string   :user_id,        null: true
      t.integer  :carrier,        null: true
      t.timestamps
    end
  end
end
