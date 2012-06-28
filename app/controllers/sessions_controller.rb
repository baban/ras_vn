# encoding: utf-8

class SessionsController < ApplicationController
  def callback
    #omniauth.auth環境変数を取得
    auth = request.env["omniauth.auth"]
    #omniuserモデルを検索
    omniuser = Omniuser.find_by_provider_and_uid(auth["provider"], auth["uid"])
    
    if omniuser
      # Omniuserモデルに:providerと:uidが見つかった場合（外部認証済み）、ログインさせる。
      session[:user_id] = omniuser.id
      redirect_to root_url, :notice => "ログインしました。"
    else
      # Omniuserモデルに:providerと:uidが無い場合（外部認証していない）、:provider,:uidを保存してから、新規登録ページへ遷移させる
      Omniuser.create_with_omniauth(auth)
      redirect_to root_url, :notice => "#{auth["info"]["name"]}さんの#{auth["provider"]}アカウントと接続しました。"
    end
  end
end

