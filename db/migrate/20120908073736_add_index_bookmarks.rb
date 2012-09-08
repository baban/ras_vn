# encoding: utf-8

class AddIndexBookmarks < ActiveRecord::Migration
  def up
    add_index :bookmarks, :user_id
    add_index :bookmarks, :recipe_id
  end

  def down
    remove_index :bookmarks, :user_id
    remove_index :bookmarks, :recipe_id
  end
end
