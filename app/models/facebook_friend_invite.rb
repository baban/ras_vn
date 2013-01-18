# encoding: utf-8

class FacebookFriendInvite < ActiveRecord::Base
  attr_accessible :deleted_at, :invite_user_id, :user_id

  def self.add( user_id, invite_user_id )
    self.create( user_id: user_id, invite_user_id: invite_user_id )
  end
end
