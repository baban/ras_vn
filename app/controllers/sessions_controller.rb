# encoding: utf-8

class SessionsController < ApplicationController
  def callback
    # get omniauth.auth enviroment values
    auth = request.env["omniauth.auth"]
    # create omniuser
    omniuser = Omniuser.find_by_provider_and_uid(auth["provider"], auth["uid"])
    
    # Omniuserモデルに:providerと:uidが存在してる？
    if omniuser
      # 存在している(=OAuth認証済み)。続けて以下を調べる。。
      # User.omniuser_id = omniuser.idとなるレコードが存在するか？
      # User.confirmed_at に値が入っている = メール確認済みか？
      user = User.find_by_omniuser_id(omniuser.id)
       if user
         # ②が存在した = Userモデルにレコードがある = Devise認証済み
         if user.confirmed_at
           # ③も存在した = メール確認済み => ログインしてルートページへ
           session[:user_id] = omniuser.id
           redirect_to root_url, notice: "ログインしました。"
         else
           # ③が無かった = メール確認が済んでいない
           redirect_to root_url, notice: "メールの確認ができていません。仮登録でメールを送信したので、確認してください。"
         end
       else
         # ②が存在しない = Userモデルにレコードがない = Devise認証はまだ => ユーザ登録ページへ
         redirect_to new_user_registration_path, notice: "#{auth["info"]["name"]}さんの#{auth["provider"]}アカウントとはすでに接続済みです。メンバー登録に必要なメールアドレスとパスワードを入力してください。"
       end
    else
      # Omniuserモデルに:providerと:uidが無い = OAuth認証がまだ
      # Omniuserモデルに:provider,:uidを保存する
      Omniuser.create_with_omniauth(auth)

      # Deviseユーザ登録の際、自分のOmniuser.idを外部キーとして保存させたい。
      # sessionにuid値を保存し、ユーザ登録のビューで使えるようにしておく。
      # sessionに保存した値を使ってOmniuserモデルを検索すれば、Omniuser.idを取得できる。
      session[:tmp_uid] = auth["uid"]
      redirect_to new_user_registration_path, :notice => "#{auth["info"]["name"]}さんの#{auth["provider"]}アカウントと接続しました。メンバー登録に必要なメールアドレスとパスワードを入力してください。"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "site logouted"
  end
end

