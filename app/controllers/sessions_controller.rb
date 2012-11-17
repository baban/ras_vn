# encoding: utf-8

# http://npb.somewhatgood.com/blog/archives/752
# FacebookとOmniauthのログイン方法の実装は上のURLを参考にしました
class SessionsController < ApplicationController
  def callback
    # get omniauth.auth enviroment values
    auth = request.env["omniauth.auth"]
    # create omniuser
    omniuser = Omniuser.find_by_provider_and_uid(auth["provider"], auth["uid"])
    
    # Omniuserモデルに:providerと:uidが存在してる？
    if omniuser
      # Oauth is authorized
      user = User.find_by_omniuser_id(omniuser.id)
       if user
         # user is exist( devise authorise is success )
         if user.confirmed_at
           # mail confirm is ended
	   # user is login
           session[:user_id] = omniuser.id
           redirect_to root_url, notice: "Đăng nhập."
         else
           redirect_to root_url, notice: "Tôi đã không thể kiểm tra e-mail. Bây giờ bạn đã gửi một email có đăng ký tạm thời, hãy kiểm tra."
         end
       else
         flash[:nickname] = auth["info"]["name"]
         flash[:email] = auth["info"]["email"]
         flash[:sex] = auth["extra"] && auth["extra"]["gender"]
         logger.info :omniuser
         logger.info flash.inspect
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
      flash[:nickname] = auth["info"]["name"]
      flash[:email] = auth["info"]["email"]
      flash[:sex] = auth["extra"] && auth["extra"]["gender"]
      logger.info :omniuser
      logger.info flash.inspect
      redirect_to new_user_registration_path, notice: "#{auth["info"]["name"]}さんの#{auth["provider"]}アカウントと接続しました。メンバー登録に必要なメールアドレスとパスワードを入力してください。"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "site logouted"
  end
end

