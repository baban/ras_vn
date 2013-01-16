# encoding: utf-8

class FacebookFriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @headers = request.headers
    @headers['Pragma'] = 'public'
    @headers['Cache-Control'] = "max-age=#{60*60*24*365}"
    @headers['Expires'] = 1.year.from_now.strftime("%a, %d %b %Y %H:%i:%s")
  end

  def invite
    friend_ids = params[:friends][:invite]
    flash[:invites] = []
    friend_ids.each do |uid|
      begin
        friend = FbGraph::User.fetch(uid, access_token: FACEBOOK_ACCESS_TOKEN)
        logger.info friend.inspect
        flash[:invites]<< friend.name
      rescue => e
        logger.error "friend invite error"
        logger.error e.inspect
      end
    end
    redirect_to action:"invited"
  end

  def invited
  end
end
