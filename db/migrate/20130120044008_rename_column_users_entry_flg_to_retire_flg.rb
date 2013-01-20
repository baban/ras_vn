# encoding: utf-8

class RenameColumnUsersEntryFlgToRetireFlg < ActiveRecord::Migration
  def up
    # rename_column :users, :entry_flg, :retire_flg
    change_column :users, :retire_flg, :boolean, default: false
  end

  def down
    rename_column :users, :retire_flg, :entry_flg
    change_column :users, :entry_flg, :boolean, default: true
  end
end
