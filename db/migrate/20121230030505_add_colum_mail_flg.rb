# encoding: utf-8

class AddColumMailFlg < ActiveRecord::Migration
  def up
    add_column    :user_profiles, :mail_status, :boolean, null: true, default: true
  end

  def down
    remove_column :user_profiles, :mail_status
  end
end
