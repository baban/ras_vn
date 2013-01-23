# encoding: utf-8

class FacebookFriendInvite < ActiveRecord::Base
  attr_accessible :deleted_at, :invite_user_id, :user_id

  module Status
    SENDED   = 1
    COMPLETE = 2
  end

  def self.add( user_id, invite_user_id )
    self.create( user_id: user_id, invite_user_id: invite_user_id )
  end

  def self.invites
    Rails.logger.info "batch start : FacebookFriendInvite.invites"
    self.where( status: 0 ).find_each do |invite|
      self.invite( invite )
    end
    Rails.logger.info "batch end   : FacebookFriendInvite.invites"
  end

  # invite mail send
  def self.invite( invite )
    invite_user = User.where( id: invite.user_id ).first
    friend = FbGraph::User.fetch( invite.invite_user_id, access_token: FACEBOOK_ACCESS_TOKEN )
    mail = UserMailer.facebook_invite( invite, invite_user, friend )
    mail.deliver if [:development,:test].include?(Rails.env.to_sym)
    invite.sended
    friend
  rescue => e
    logger.error :frinend_invite_error
    logger.error invite.inspect
    logger.error e.inspect
  end

  def sended
    self.status = Status::SENDED
    self.save
    self
  end

  def complete
    self.status = Status::COMPLETE
    self.completed_at = DateTime.now
    self.save
    self
  end
end
