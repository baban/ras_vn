# encoding: utf-8

class AddIndexCommerceCodeLogs < ActiveRecord::Migration
  def up
    add_index :commerce_code_logs, :session_id, unique: true
  end

  def down
    remove_index :commerce_code_logs, :session_id
  end
end
