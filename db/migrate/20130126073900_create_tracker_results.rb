# encoding: utf-8

class CreateTrackerResults < ActiveRecord::Migration
  def change
    create_table :tracker_results do |t|
      t.date    :day,   null: false
      t.integer :come,  null: false, default: 0
      t.integer :entry, null: false, default: 0

      t.timestamps
    end
  end
end
