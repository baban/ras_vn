# encoding: utf-8

class AddColumnDeletedAtToRecipeComments < ActiveRecord::Migration
  def up
    add_column    :recipe_comments, :deleted_at, :datetime, null: true
  end
  def down
    remove_column :recipe_comments, :deleted_at
  end
end
