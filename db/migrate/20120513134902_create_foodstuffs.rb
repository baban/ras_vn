# encoding: utf-8

class CreateFoodstuffs < ActiveRecord::Migration
  def change
    create_table :foodstuffs do |t|
      t.integer :recipe_id,  null: false
      t.string  :name,       null: false, default: ''
      t.string  :amount,     null: false, default: ''

      t.time    :deleted_at, null: true
      t.timestamps
    end
  end
end
