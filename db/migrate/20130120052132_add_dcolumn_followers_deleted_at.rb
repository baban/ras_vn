# encoding: utf-8

class AddDcolumnFollowersDeletedAt < ActiveRecord::Migration
  def up
    add_column    :followers, :deleted_at, :datetime, null: true
  end

  def down
    remove_column :followers, :deleted_at
  end
end
