# encoding: utf-8

class CreateTplSets < ActiveRecord::Migration
  def change
    create_table :tpl_sets do |t|
      t.string :name,    null: false
      t.text   :content, null: false, default: ""

      t.timestamps
    end
  end
end
