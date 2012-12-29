# encoding: utf-8

class CreateFailMails < ActiveRecord::Migration
  def change
    create_table :fail_mails do |t|
      t.string  :email, null: false
      t.integer :count, null: false, default: 0

      t.timestamps
    end
  end
end
