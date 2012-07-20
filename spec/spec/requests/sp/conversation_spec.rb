# encoding: utf-8
require 'spec_helper'

describe "Sp::ConversationsController" do
  describe "GET /sp/conversations/:id" do
    context "未ログイン時に" do
      before do
        Capybara.current_driver = :sp
        @user = FactoryGirl.create(:user)
        @user2 = FactoryGirl.create(:user)
        @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
        @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => @user)
        @conversation = FactoryGirl.create(:conversation, :purchase => @purchase)
        FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => @user) 
        FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => @user2) 
      end

      it "メッセージ詳細にアクセスしようとしたらsp版のサインインのページに飛ばされること" do
        visit sp_conversation_path(@purchase.user.conversation(@purchase))
        current_path.should == sp_signin_path
      end
    end

    context "ログイン済の時に" do
      include_context "capybara_sp_login"

      context "メッセージを送信できる相手がいる場合" do
        before do
          @user2 = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
          @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
          @conversation = FactoryGirl.create(:conversation, :purchase => @purchase)
          FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => user) 
          FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => @user2) 
          FactoryGirl.create(:message, :conversation => @conversation, :user => @user2, :to_user => user, :body => "fugafuga") 

          # sp版のメッセージ詳細ページにアクセス
          visit sp_conversation_path(@purchase.user.conversation(@purchase))
        end

        it "メッセージが送信できること" do
          # メッセージの内容を入力して、画面遷移
          fill_in "message_body", :with => "" 
          find("input.btn_review").click

          # バリデーションにひっかかって戻ってくる
          page.should have_content("本文を入力してください。")
          
          # 再度入力
          fill_in "message_body", :with => "hogehogehogehoge" 
          find("input.btn_review").click

          # メッセージ送信後sp版のメッセージ詳細ページに遷移し、メッセージも保存されていること
          current_path.should == sp_conversation_path(@purchase.user.conversation(@purchase))
          find("p.love_txt").should have_content("hogehogehogehoge")
        end

        it "メッセージが削除できること" do
          # メッセージの内容を入力して、画面遷移
          fill_in "message_body", :with => "hogehogehogehoge" 
          find("input.btn_review").click

          # メッセージ送信後、メッセージが保存されていること
          find("p.love_txt").should have_content("hogehogehogehoge")

          # メッセージ削除後、メッセージ詳細ページに遷移しメッセージが存在しないこと
          find("p.btn_delete a").click
          current_path.should == sp_conversation_path(@purchase.user.conversation(@purchase))
          find("p.love_txt").should_not have_content("hogehogehogehoge")
        end

        it "相手のメッセージが見られること" do
          # 相手のメッセージが見られること
          find("p.love_txt").should have_content("fugafuga")
        end
      end
    end
  end
end
