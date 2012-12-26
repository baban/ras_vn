# encoding: utf-8

class AddColumnStatusToRecipes < ActiveRecord::Migration
  def up
    add_column    :recipes, :status, :integer, null: false, default: 0
  end

  def down
    remove_column :recipes, :status
  end
end
