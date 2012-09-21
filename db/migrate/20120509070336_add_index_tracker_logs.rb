# encoding: utf-8

class AddIndexTrackerLogs < ActiveRecord::Migration
  def up
    add_index :tracker_logs, :session_id, unique: true
    add_index :tracker_logs, :user_id      
  end

  def down
    remove_index :tracker_logs, :session_id
    remove_index :tracker_logs, :user_id      
  end
end
