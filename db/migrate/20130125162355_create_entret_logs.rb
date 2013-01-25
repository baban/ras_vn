# encoding: utf-8

class CreateEntretLogs < ActiveRecord::Migration
  def change
    create_table :entret_logs do |t|
      t.integer :user_id, null: false
      t.integer :status,  null: false

      t.timestamps
    end
  end
end
