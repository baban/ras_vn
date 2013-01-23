# encoding: utf-8

class AddColumnFacebookFriendInviteCompletedAtStatus < ActiveRecord::Migration
  def up
    add_column     :facebook_friend_invites, :status, :integer, null: false, default: 0
    add_column     :facebook_friend_invites, :completed_at, :datetime, null: true
  end

  def down
    remove_column :facebook_friend_invites, :status
    remove_column :facebook_friend_invites, :completed_at
  end
end
