# encoding: utf-8

class CreateTrackerLogs < ActiveRecord::Migration
  def change
    create_table :tracker_logs do |t|
      t.string   :session_id,   null: false
      t.string   :tracker_code, null: false
      t.datetime :limit_at,     null: true
      t.datetime :completed_at, null: true
      t.string   :user_id,      null: true
      t.integer  :carrier,      null: true
      t.timestamps
    end
  end
end
