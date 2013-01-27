# encoding: utf-8

class CreateEntretResults < ActiveRecord::Migration
  def change
    create_table :entret_results do |t|
      t.date    :day,          null: false
      t.integer :entry,        null: false, default: 0
      t.integer :retire,       null: false, default: 0
      t.integer :entret,       null: false, default: 0
      t.integer :entry_total,  null: false, default: 0
      t.integer :retire_total, null: false, default: 0
      t.integer :active_total, null: false, default: 0

      t.timestamps
    end
  end
end
