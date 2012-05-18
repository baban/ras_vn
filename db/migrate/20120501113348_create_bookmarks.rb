#encoding: utf-8

class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :user_id,    null: false
      t.integer :shop_id,    null: false
      t.time    :deleted_at, null: true
      
      t.timestamps
    end
  end
end
