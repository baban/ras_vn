# encoding: utf-8

class AddIndexAffiriateLogs < ActiveRecord::Migration
  def up
    add_index :affiriate_logs, :session_id
    add_index :affiriate_logs, :user_id
  end

  def down
    remove_index :affiriate_logs, :session_id
    remove_index :affiriate_logs, :user_id
  end
end
