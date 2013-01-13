# encoding: utf-8

class FacebookFriendsController < ApplicationController
  def index
    # @friends = File.binread(Rails.root.to_path+"/resource/friends.data")
    user = FbGraph::User.fetch('100002130858178', access_token: FACEBOOK_ACCESS_TOKEN)
    logger.info :user
    logger.info user.inspect
    @friends = user.friends
    logger.info :friends
    logger.info @friends.inspect
    File.binwrite(Rails.root.to_path+"/resources/friends.data", Marshal.dump(@friends))
  end

  def invite
  end

  def invited
  end
end
