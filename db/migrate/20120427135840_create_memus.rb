# encoding: utf-8

class CreateMemus < ActiveRecord::Migration
  def change
    create_table :memus do |t|
      t.name :string,   null: false, default: ""
      t.price :integer, null: false, default: 0
      t.comment :text,  null: true

      t.timestamps
    end
  end
end
