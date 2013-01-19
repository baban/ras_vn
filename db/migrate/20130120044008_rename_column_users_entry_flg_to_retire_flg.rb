# encoding: utf-8

class RenameColumnUsersEntryFlgToRetireFlg < ActiveRecord::Migration
  def up
    rename_column :users, :entry_flg, :retire_flg
  end

  def down
    rename_column :users, :retire_flg, :entry_flg
  end
end
