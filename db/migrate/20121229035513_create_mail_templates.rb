# encoding: utf-8

class CreateMailTemplates < ActiveRecord::Migration
  def change
    create_table :mail_templates do |t|
      t.string   :title,     null: false, default: ""
      t.text     :content,   null: false, default: ""
      t.datetime :opened_at, null: true
      t.datetime :closed_at, null: true
      t.string   :from,      null: false
      t.string   :reply_to,  null: false
      t.string   :bcc,       null: false
      t.boolean  :public,    null: false, default: false

      t.timestamps
    end
  end
end
