# encoding: utf-8

class AddIndexTrackerLogs < ActiveRecord::Migration
  def up
    add_index :tracker_logs, :session_id, unique: true
  end

  def down
    remove_index :tracker_logs, :session_id
  end
end
