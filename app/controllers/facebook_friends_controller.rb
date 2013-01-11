# encoding: utf-8

class FacebookFriendsController < ApplicationController
  def index
    @friend_list = FbGraph::FriendList.new('100002130858178', access_token: FACEBOOK_ACCESS_TOKEN )
    @members = @friend_list.members
    logger.info :members
    logger.info @members.inspect
  end

  def invite
  end

  def invited
  end
end
