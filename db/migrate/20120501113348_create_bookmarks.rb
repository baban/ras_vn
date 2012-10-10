#encoding: utf-8

class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id,   null: false
      t.integer :recipe_id, null: false
      t.integer :del_flg,   null: false, default: 0
      
      t.timestamps
    end
  end
end
