# encoding: utf-8
require 'spec_helper'
require 'support/before_login_context'
require 'support/database_cleaner_context'

describe UsersController do
  describe "GET show/:url_name" do
    context "ユーザーが存在しなければ" do
      it "404になること" do
        lambda {
          get :show, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound 
      end
    end 

    context "ユーザーが存在すれば" do
      let(:ticket) { FactoryGirl.create(:opening_ticket) }
      let(:user) { FactoryGirl.create(:user, :recommended_ticket => ticket) }

      before(:all) do
        10.times do
          FactoryGirl.create(:opening_ticket, :user => user)
        end
      end
      include_context "database_cleaner"

      before do
        get :show, :id => user.url_name
      end

      it "@userがあること" do
        assigns[:user].should == user  
      end

      it "@ticketsが10件あること" do
        assigns[:tickets].should have(10).item 
      end

      it "@pickup_ticketがあること" do
        assigns[:pickup_ticket].should_not be_nil
      end

    end
  end
  describe "GET new" do

    context "ログインしている場合" do
      include_context "ログインする"

      it "トップページにリダイレクトされること" do
        get :new
        response.should redirect_to root_path
      end  
    end

    context "sessionにあるtmp_userが存在しない場合" do
      before do
        session[:tmp_user_id] = nil
        get :new
      end

      it "@userがUserのインスタンスであること" do
        assigns[:user].should be_an_instance_of User
      end

      it "layoutにapplicationが使われること" do
        response.should render_template("layouts/application")
      end

      it "リクエストが成功すること" do
        response.should be_success
      end
    end

    context "sessionにあるtmp_userがDBに存在する場合" do
      let(:tmp_user) { FactoryGirl.create(:tmp_user) }

      before do
        session[:tmp_user_id] = tmp_user.id
        get :new
      end

      it "@userがUserのインスタンスであること" do
        assigns[:user].should be_an_instance_of User
      end

      it "layoutにapplicationが使われること" do
        response.should render_template("layouts/application")
      end

      it "リクエストが成功すること" do
        response.should be_success
      end
    end
  end

  describe "POST create" do
    context "sessionにあるtmp_userが存在しない場合" do
      let(:user_params) { FactoryGirl.attributes_for(:user).merge(:accept => 1)}
      before do
        session[:tmp_user_id] = nil
      end

      context "正しいデータを送信した場合" do
        it "usersテーブルにデータが登録されること" do
          expect {
            post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          }.to change(User, :count).by(1)
        end

        it "servicesテーブルにデータが登録されないこと" do
          expect {
            post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          }.to_not change(Service, :count)
        end

        it "session[:user_id]に登録したユーザーのIDが入ること" do
          post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          session[:user_id].should_not be_nil 
        end

        it "完了画面にリダイレクトされること" do
          post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          response.should redirect_to complete_users_path 
        end
      end

      context "不正なデータを送信した場合" do
        before do
          post :create, :user => nil, :commit => I18n.t("user.submit_button.create")
        end

        it "newがrenderされること" do
          response.should render_template(:new) 
        end

        it "layoutにapplicationが使われること" do
          response.should render_template("layouts/application")
        end 
      end 
    end

    context "sessionにあるtmp_userがDBに存在し" do
      let(:tmp_user) { FactoryGirl.create(:tmp_user) }
      let(:user_params) { FactoryGirl.attributes_for(:user).merge(:accept => 1)}
      before do
        session[:tmp_user_id] = tmp_user.id
      end

      context "正しいデータを送信した場合" do
        it "usersテーブルにデータが登録されること" do
          expect {
            post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          }.to change(User, :count).by(1)
        end

        it "servicesテーブルにデータが登録されること" do
          expect {
            post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          }.to change(Service, :count).by(1)
        end

        it "session[:tmp_user_id]がnilになること" do
          post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          session[:tmp_user_id].should be_nil
        end

        it "session[:user_id]に登録したユーザーのIDが入ること" do
          post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          session[:user_id].should_not be_nil 
        end

        it "tmp_userが削除されること" do
          post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          TmpUser.find_by_id(tmp_user.id).should be_nil 
        end

        it "完了画面にリダイレクトされること" do
          post :create, :user => user_params, :commit => I18n.t("user.submit_button.create")
          response.should redirect_to complete_users_path 
        end
      end

      context "不正なデータを送信した場合" do
        before do
          post :create, :user => nil, :commit => I18n.t("user.submit_button.create")
        end

        it "newがrenderされること" do
          response.should render_template(:new) 
        end

        it "layoutにapplicationが使われること" do
          response.should render_template("layouts/application")
        end
      end
    end
  end

  describe "GET complete" do
    context "ログインしている場合" do
      include_context "ログインする"

      before do
        session[:callback_url] = "http://abilie.com"
        get :complete 
      end

      it "@callback_urlにsession[:callback_url]がセットされていること" do
        assigns[:callback_url].should == "http://abilie.com"  
      end

      it "session[:callback_url]がnilになること" do
        session[:callback_url].should be_nil 
      end
    end

    context "ログインしていない場合" do
      before do
        get :complete 
      end

      it "ログイン画面にリダイレクトされること" do
        response.should redirect_to(signin_path)
      end     
    end
  end

  describe "PUT follow" do
    context "ログインしていなければ" do
      it "ログイン画面にリダイレクトされること" do
        put :follow, :id => "hoge", :format => "json"
      end
    end

    context "ログインしてたら" do
      include_context "ログインする"
      let(:target_user) { FactoryGirl.create(:user) }
      render_views
      context "未フォローの場合" do
        it "Friendshipsにデータが登録されること" do
          expect { 
            put :follow, :id => target_user.url_name, :format => "json"
          }.to change(Friendship, :count).by(1)
        end

        it "success用のjsonが返ること" do
          put :follow, :id => target_user.url_name, :format => "json"
          response.body.should == {:success => true, :response => {:unfollow_url => unfollow_user_path(target_user.url_name)}}.to_json   
        end
      end

      context "すでにフォローしている場合" do
        before do
          user.follow target_user
        end

        it "error用のjsonが返ること" do
          put :follow, :id => target_user.url_name, :format => "json"
          response.body.should == {:success => false}.to_json
        end
      end
    end
  end

  describe "PUT unfollow" do
    context "ログインしていなければ" do
      it "ログイン画面にリダイレクトされること" do
        put :unfollow, :id => "hoge", :format => "json"
      end
    end

    context "ログインしていて" do
      include_context "ログインする"
      let(:target_user) { FactoryGirl.create(:user) }
      render_views
      context "未フォローの場合" do
        it "error用のjsonが返ること" do
          put :unfollow, :id => target_user.url_name, :format => "json"
          response.body.should == {:success => false}.to_json
        end
      end

      context "すでにフォローしている場合" do
        before do
          user.follow target_user
        end

        it "Friendshipが削除されること" do
          put :unfollow, :id => target_user.url_name, :format => "json"
          Friendship.find_by_user_id_and_friend_id(user.id, target_user.id).should be_nil
        end

        it "success用のjsonが返ること" do
          put :unfollow, :id => target_user.url_name, :format => "json"
          response.body.should == {:success => true, :response => {:follow_url => follow_user_path(target_user.url_name)}}.to_json   
        end
      end
    end
  end

  describe "GET followings" do

    context "ユーザーが存在しなければ" do
      it "404になること" do
        lambda {
          get :followings, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound 
      end
    end 

    context "ユーザーが存在すれば" do
      include_context "ログインする"
      let(:target_user) { FactoryGirl.create(:user) }

      before do
        user.follow target_user
      end

      it "@usersがあること" do
        get :followings, :id => user.url_name
        assigns[:users].should have(1).item 
      end
    end 

  end

  describe "GET followers" do
    context "ユーザーが存在しなければ" do
      it "404になること" do
        lambda {
          get :followers, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound 
      end
    end 

    context "ユーザーが存在すれば" do
      include_context "ログインする"
      let(:target_user) { FactoryGirl.create(:user) }

      before do
        target_user.follow user
      end

      it "@usersがあること" do
        get :followers, :id => user.url_name
        assigns[:users].should have(1).item 
      end
    end 
  end

  describe "GET activities" do
    context "ユーザーが存在しなければ" do
      it "404になること" do
        lambda {
          get :activities, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound 
      end
    end 

    context "ユーザーが存在すれば" do
      include_context "ログインする"

      before(:all) do
        13.times do
          FactoryGirl.create(:opening_ticket, :user => user)
        end
      end
      include_context "database_cleaner"

      it "@activitiesが12件あること" do
        get :activities, :id => user.url_name
        assigns[:activities].should have(12).item 
      end
    end 
  end

  describe "GET reviewed" do
    context "ユーザーが存在しなければ" do
      it "404になること" do
        lambda {
          get :reviewed, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound 
      end
    end 

    context "ユーザーが存在すれば" do
      let(:user) { FactoryGirl.create(:user) }
      let(:ticket) { FactoryGirl.create(:ticket, :user => user ) }

      before(:all) do
        13.times do
          FactoryGirl.create(:review, :user => FactoryGirl.create(:user), :ticket => ticket)
        end
      end
      include_context "database_cleaner"

      before do
        get :reviewed, :id => user.url_name
      end

      it "@userがあること" do
        assigns[:user].should == user
      end

      it "@reviewsがあること" do
        assigns[:reviews].should == Review.joins(:ticket).where("tickets.user_id = ?", user.id).page().per(12)
      end
    end
  end

  describe "GET boards" do
    context "ユーザーが存在しなければ" do
      it "404になること" do
        lambda {
          get :boards, :id => "not_found"
        }.should raise_error ActiveRecord::RecordNotFound 
      end
    end 

    context "ユーザーが存在すれば" do
      let(:user) { FactoryGirl.create(:user) }

      before(:all) do
        12.times do
          FactoryGirl.create(:note, :user => user)
        end
      end
      include_context "database_cleaner"

      before do
        get :boards, :id => user.url_name
      end

      it "@userがあること" do
        assigns[:user].should == user
      end

      it "@noteがあること" do
        assigns[:notes].should have(10).items
      end
    end
  end

  describe "GET verify_email" do
    context "ログインしていて" do
      include_context "ログインする"

      context "auth_codeが正しくて" do
        context "既に認証済みの場合" do
          let(:user) { FactoryGirl.create(:user) }
          before do
            auth_url = user.create_verify_url
            auth_code = auth_url.match(/auth_code=(.*)/)[1]
            get :verify_email,:auth_code => auth_code
          end
          it "メアド編集画面にリダイレクトされること" do
            response.should redirect_to(edit_email_user_path(user.url_name))
          end     
        end

        context "未認証の場合" do
          let(:user) { FactoryGirl.create(:unverified_email_user) }
          before do
            auth_url = user.create_verify_url
            auth_code = auth_url.match(/auth_code=(.*)/)[1]
            get :verify_email,:auth_code => auth_code
          end
          it "メール認証フラグがtrueになること" do
            user.reload
            user.verify_email_flag.should be_true          
          end

          it "完了画面にリダイレクトされること" do
            response.should redirect_to(authenticated_users_path)
          end     
        end
      end

      context "auth_codeが不正な場合" do
        let(:user) { FactoryGirl.create(:unverified_email_user) }
        before do
          get :verify_email,:auth_code => "not_correct_code" 
        end

        it "TOPページにリダイレクトすること" do
          response.should redirect_to(root_path)
        end
      end
    end

    context "ログインしていない場合" do
      before do
        get :verify_email
      end

      it "ログイン画面にリダイレクトされること" do
        response.should redirect_to(signin_path)
      end
    end
  end

  describe "GET forgot_password" do
    context "削除済みユーザの場合" do
      let(:user) {create(:deleted_user) }
      it "メールが送信されないこと" do
        UserMailer.should_not_receive(:resend_password).with(user)
        get :forgot_password, {:user => user.attributes}
      end
    end
    context "ログインしている場合" do
      include_context "ログインする"
      let(:user) { FactoryGirl.create(:user) }
      it "ログインユーザにメールが送信されること" do
        get :forgot_password, {:user => user.attributes}
        ActionMailer::Base.deliveries.last.to.should == [user.email]
      end
    end

    context "ログインしていない場合" do
      let(:user) { FactoryGirl.create(:user) }
      before { get :forgot_password, {:user => user.attributes} }
      it "ログインユーザにメールが送信されること" do
        ActionMailer::Base.deliveries.last.to.should == [user.email]
      end
    end
  end

  describe "GET edit_reset_password" do
    context "ログインしている場合" do
      include_context "ログインする"
      let(:user) { FactoryGirl.create(:user) }
      let(:user2) { user }
      before do
        User.stub(:find_user_id_by_auth_code).and_return(user2.id)
        get :edit_reset_password, :token => "hoge" 
      end 

      context "ログイン中ユーザとパスワード変更要求ユーザが同じ場合" do
        it "@userがあること" do
          assigns[:user].should == user
        end
      end

      context "ログイン中ユーザとパスワード変更要求ユーザが異なる場合" do
        let(:user2) { create(:user) }
        it "TOP画面にリダイレクトされること" do
          response.should redirect_to(root_path)
        end
      end
    end

    context "ログインしていない場合" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        User.stub(:find_user_id_by_auth_code).and_return(user.id)
        get :edit_reset_password, :token => "hoge"
      end 

      it "@userがあること" do
        assigns[:user].should == user
      end

      it "sessionにパスワード変更ユーザIDが保持されること" do
        session[:reset_password_user_id].should == user.id
      end
    end
  end
end
