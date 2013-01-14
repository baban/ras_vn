# encoding: utf-8

class FacebookFriendsController < ApplicationController
  def index
    # TODO: ログイン済みユーザーチェック
    # TODO: facebookから来たのかをチェック
    # TODO: facebookID取得
    # @friends = Marshal.load(File.binread(Rails.root.to_path+"/resource/friends.dat"))
    
    logger.info current_user.inspect
    omniuser = Omniuser.find(current_user.omniuser_id)
    logger.info :omniuser
    logger.info omniuser.inspect
    return redirect_to "/" unless omniuser.provider=="facebook"

    uid = omniuser.uid
    logger.info uid
    user = FbGraph::User.fetch(uid, access_token: FACEBOOK_ACCESS_TOKEN)
    logger.info :user
    logger.info user.inspect
    @friends = user.friends
    logger.info :friends
    logger.info @friends.inspect
    # File.binwrite(Rails.root.to_path+"/friends.data", Marshal.dump(@friends))
  end

  def invite
    friend_ids = params[:friends][:invite]
    flash[:invites] = []
    friend_ids.each do |uid|
      begin
        friend = FbGraph::User.fetch(uid, access_token: FACEBOOK_ACCESS_TOKEN)
        logger.info friends.inspect
        flash[:invites]<< friend.name
      rescue => e
        logger.error "friend invite error"
        logger.error e.inspect
      end
    end
    redirect_to action:"invited"
  end

  def invited
    @friends = flash[:invites].join(", ")
  end
end
