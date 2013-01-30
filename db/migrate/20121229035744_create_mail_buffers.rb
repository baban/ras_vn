# endocing: utf-8

class CreateMailBuffers < ActiveRecord::Migration
  def change
    create_table :mail_buffers do |t|
      t.integer  :user_id,    null: false
      t.string   :from,       null: false
      t.string   :to,         null: false
      t.string   :subject,    null: false, default: ""
      t.text     :body,       null: false, default: ""
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end
