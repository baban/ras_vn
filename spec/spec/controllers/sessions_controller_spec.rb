# encoding: utf-8
require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    context "登録済みユーザーで" do
      before do
        @service = FactoryGirl.create(:facebook_service)

        request.env["omniauth.auth"] = {
          "provider" => "facebook",
          "uid" => @service.uid,
          "credentials" => {
            "token" => "moge"
          }
        }
      end

      context "Facebookユーザーの場合" do
        it "access_tokenが更新されること" do
            post :create
            @service.reload
            @service.access_token_decrypt.should == "moge"
        end
      end 
    end   
  end

  describe "POST password_login" do
    let(:user) { create(:user) }
    let(:uid) { user.url_name }
    let(:password) { user.password }
    before { post :password_login, {:user => {:url_name => uid, :password => password}} }

    context "アビリエIDとパスワードが正しい場合" do
      context "正規ユーザーの場合" do
        it "loginに成功すること" do
          session[:user_id].should eq user.id
        end
        it "トップページにリダイレクトされること" do
          response.should redirect_to root_path 
        end
      end

      context "退会済みユーザーの場合" do
        let(:user) { create(:deleted_user) }

        it "loginに失敗すること" do
          session[:user_id].should_not eq user.id
        end
      end
    end 

    context "アビリエIDとパスワードが不正の場合" do
      let(:password) { "tigau" }
      it "loginに失敗すること" do
        session[:user_id].should_not eq user.id
      end
      it "flashを設定すること" do
        flash[:notice].should be_present
      end 
      it "ログインページが表示されること" do
        response.should render_template(:new) 
      end
    end 
  end

  describe "GET destroy" do
    before do 
      session[:user_id] = FactoryGirl.create(:user).id
      get :destroy
    end

    it "トップページにリダイレクトされること" do
      response.should redirect_to root_path 
    end

    it "session[:user_id]がnilになること" do
      session[:user_id].should be_nil 
    end
  end
  describe "GET failure" do
    before do
      get :failure
    end

    it "トップページにリダイレクトされること" do
      response.should redirect_to root_path 
    end
  end
end
