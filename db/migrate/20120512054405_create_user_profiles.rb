# encoding: utf-8

class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer  :user_id,       nuLL: false
      t.string   :image,         null: true
      t.string   :nickname,      null: false, default:""
      t.integer  :sex,           null: true
      t.string   :first_name,    nulL: true,  default:""
      t.string   :last_name,     nulL: true,  default:""
      t.date     :birthday,      null: true
      t.string   :mail_address,  null: true
      t.integer  :prefecture_id, null: false, default: 0
      t.integer  :area_id,       null: false, default: 0
      t.text     :comment,       null: false, default: ""

      t.timestamps
    end
  end
end
