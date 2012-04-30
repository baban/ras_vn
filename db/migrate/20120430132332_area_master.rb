# encoding: utf-8

class AreaMaster < ActiveRecord::Migration
  def change
    create_table :area_masters do |t|
      t.integer :parent_id, null: false
      t.string  :name,      null: false
      t.integer :area_type, null: false
      t.timestamps
    end
  end
end
