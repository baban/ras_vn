# encoding: utf-8

class FacebookFriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if [:development,:test].include?(Rails.env.to_sym)
      @friends = Marshal.load(File.binread(Rails.root.to_path+"/resource/friends.dat")).sort{ |a,b| a.name<=>b.name }
    else
      logger.info current_user.inspect
      return redirect_to "/" unless current_user.facebook?

      uid = current_user.facebook.uid
      logger.info "uid : #{uid} "
      user = FbGraph::User.fetch(uid, access_token: FACEBOOK_ACCESS_TOKEN)
      logger.info " user : #{user.inspect} "
      @friends = user.friends.sort{ |a,b| a.name<=>b.name }
      logger.info " friends : #{@friends.inspect} "
      # File.binwrite(Rails.root.to_path+"/friends.data", Marshal.dump(@friends))
    end
  end

  def invite
    friend_ids = params[:invite]
    friend_ids.each do |uid|
      begin
        logger.info "uid : #{uid} "
        FacebookFriendInvite.add( current_user.id, uid )
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
