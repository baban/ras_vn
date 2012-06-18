# encoding: utf-8

class CreateUserProfileVisibilities < ActiveRecord::Migration
  def change
    create_table :user_profile_visibilities do |t|
      t.boolean :user_id,       nuLL: false, default: true
      t.boolean :nickname,      null: false, default: true
      t.boolean :sex,           null: false, default: true
      t.boolean :first_name,    nulL: false, default: true
      t.boolean :last_name,     nulL: false, default: true
      t.boolean :blood_type,    null: false, default: true
      t.boolean :birthday,      null: false, default: true
      t.boolean :mail_address,  null: false, default: true
      t.boolean :postcode,      null: false, default: true
      t.boolean :address,       null: false, default: true
      t.boolean :address_point, null: false, default: true
      t.timestamps
    end
  end
end
