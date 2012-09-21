# encoding: utf-8

class CreateAffiriateLogs < ActiveRecord::Migration
  def change
    create_table :affiriate_logs do |t|
      t.string   :session_id,     null: false, unique: true
      t.string   :affiriate_code, null: false
      t.integer  :affiriate_type, null: false
      t.integer  :user_id,        null: true
      t.datetime :completed_at,   null: true
      t.datetime :retired_at,     null: true

      t.timestamps
    end
  end
end
