# encoding: utf-8

class AddDistincts < ActiveRecord::Migration
  def up
    add_index :distincts, :prefecture_id
  end

  def down
    remove_index :distincts, :prefecture_id
  end
end
