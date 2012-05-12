# encoding: utf-8

class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer  :user_id,       nuLL: false
      t.string   :nickname,      null: false, default:""
      t.boolean  :sex,           null: true
      t.integer  :blood_type,    null: true
      t.datetime :birthday,      null: true
      t.string   :mail_address,  null: true
      t.string   :postcode,      null: false, default: ''
      t.string   :address,       null: false, default: ''

      t.integer  :address_point, null: true
      t.timestamps
    end
  end
end
