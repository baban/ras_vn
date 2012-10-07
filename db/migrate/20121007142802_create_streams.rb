# encoding: utf-8

class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :user_id,     null: false
      t.integer :stream_type, null: false
      t.text    :title,       null: false, default: ""

      t.timestamps
    end
  end
end
