# encoding: utf-8

class FacebookFriendsController < ApplicationController
  def index
    @friedns = FbGraph::User.me(ACCESS_TOKEN)
  end

  def invite
  end

  def invited
  end
end
