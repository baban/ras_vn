 # encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "info@cook24.vn"

  def welcome( email )
    @email = email
    mail( subject: "welcome", to: email )
  end
  
  # debug code
  # if you wanto to debug view
  # argument values get below source
  #
  # @invite = FacebookFriendInvite.new
  # @invite_user = User.first
  # @friend = Marshal.load(File.binread(Rails.root.to_path+"/resource/hoang.dat"))
  def facebook_friend_invite( invite, invite_user, friend )
    @invite      = invite
    @friend      = friend
    @invite_user = invite_user

    Rails.logger.info " facebook invite emai send to : #{friend.email} "
    #mail( subject:"#{friend.name} join cook24.vn!!", to: friend.email )
    mail( subject:"#{friend.name} mời bạn tham gia cook24.vn", to: friend.email )
  end
end

