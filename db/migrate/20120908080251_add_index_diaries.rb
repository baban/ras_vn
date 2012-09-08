# encoding: utf-8

class AddIndexDiaries < ActiveRecord::Migration
  def up
    add_index :diaries, :user_id
  end

  def down
    remove_index :diaries, :user_id
  end
end
