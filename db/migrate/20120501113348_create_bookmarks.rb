#encoding: utf-8

class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id, null: false
      t.integer :shop_id, null: false
      t.timestamps
    end
  end
end
