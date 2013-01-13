# encoding: utf-8

class FacebookFriendsController < ApplicationController
  def index
    user = FbGraph::User.fetch('100002130858178', access_token: FACEBOOK_ACCESS_TOKEN)
    logger.info :user
    logger.info user.inspect
    @friends = user.friends
    logger.info :friends
    logger.info @friends.inspect
    File.binwrite(Rails.root.to_path+"/friends.data", @friends)
  end

  def invite
  end

  def invited
  end
end
