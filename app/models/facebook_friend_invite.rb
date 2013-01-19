# encoding: utf-8

class FacebookFriendInvite < ActiveRecord::Base
  attr_accessible :deleted_at, :invite_user_id, :user_id

  def self.add( user_id, invite_user_id )
    self.create( user_id: user_id, invite_user_id: invite_user_id )
  end

  def self.invites
    Rails.logger.info "batch start : FacebookFriendInvite.invites"
    self.find_each do |invite|
      next if [:development,:test].include?(Rails.env.to_sym)
      friend = self.invite( invite.invite_user_id )
      invite.delete
    end
    Rails.logger.info "batch end   : FacebookFriendInvite.invites"
  end

  def self.invite( uid )
    friend = FbGraph::User.fetch(uid, access_token: FACEBOOK_ACCESS_TOKEN)
    friend.app_request!( message: 'Join cook24.vn!' )
    friend
  rescue => e
    logger.error :frinend_invite_error
    logger.error invite.inspect
    logger.error e.inspect
  end
end
