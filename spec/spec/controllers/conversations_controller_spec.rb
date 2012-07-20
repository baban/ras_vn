# encoding: utf-8
require 'spec_helper'
require 'support/before_login_context'
require 'support/database_cleaner_context'

describe ConversationsController do

  describe "GET 'index'" do

    context "一覧ページにアクセスした場合" do
      context "ログインしていれば" do
        before do
          get :index 
        end
        it "ログイン画面にリダイレクトされること" do
          response.should redirect_to(signin_path)
        end     
      end

      context "ログインしていれば" do
        include_context "ログインする"
        before(:all) do
          user2 = FactoryGirl.create(:user)
          11.times do
            purchase = FactoryGirl.create(:purchase, :user => user)
            conversation = FactoryGirl.create(:conversation, :purchase => purchase)
            FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
            FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2) 
            FactoryGirl.create(:message, :conversation => conversation, :user => user, :to_user => user2) 
          end
        end
        include_context "database_cleaner"

        it 'index のテンプレートが読まれること' do
          get :index
          response.should render_template('index')
        end
        it "@conversationsが10件あること(ページングは10件)" do
          get :index
          assigns[:conversations].should have(10).items 
        end
      end
    end
  end
end
