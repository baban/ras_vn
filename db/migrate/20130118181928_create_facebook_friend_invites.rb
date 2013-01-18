# encoding: utf-8

class CreateFacebookFriendInvites < ActiveRecord::Migration
  def change
    create_table :facebook_friend_invites do |t|
      t.integer  :user_id,        null: false
      t.string   :invite_user_id, null: false
      t.datetime :deleted_at,     null: true

      t.timestamps
    end
  end
end
