# encoding: utf-8

class RenameTrackerLog < ActiveRecord::Migration
  def up
    execute "ALTER TABLE commerce_code_logs MODIFY COLUMN carrier varchar(255);"
    rename_table :commerce_code_logs, :tracker_logs
    rename_column :tracker_logs, :commerce_code, :tracker_code
  end

  def down
    execute "ALTER TABLE tracker_logs       MODIFY COLUMN carrier integer;"
    rename_table :tracker_logs, :commerce_code_logs
    rename_column :commerce_code_logs, :tracker_code, :commerce_code
  end
end
