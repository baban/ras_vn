# encoding: utf-8
require 'spec_helper'

describe "Sp::Home" do
  describe "GET /sp/home" do
    context "未ログイン時に" do
      it "sp版のサインインのページに飛ばされること" do
        Capybara.current_driver = :sp
        visit sp_home_path 
        current_path.should == sp_signin_path
      end
    end

    context "ログイン済の時に" do
      include_context "capybara_sp_login"

      context "購入したチケットがある場合" do
        before do
          @user2 = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
          @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
          conversation = FactoryGirl.create(:conversation, :purchase => @purchase)
          FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
          FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 
        end

        it "購入したチケットが表示されること" do
          # sp版のマイページにアクセス
          visit sp_home_path 
          # 購入したチケットがあることを確認
          find(".txt_tkt_info").should have_content @ticket.title
        end

        it "購入したチケットの出品者にメッセージを送るページに遷移できること" do
          # spのマイページにアクセス
          visit sp_home_path 
          # [メッセージを送る]リンクをクリック
          find(".btn_send_msg a").click
          current_path.should == sp_conversation_path(@purchase.user.conversation(@purchase))
        end

        it "購入したチケットをレビューするページに遷移できること" do
          # spのマイページにアクセス
          visit sp_home_path 
          # [評価する]リンクをクリック
          find(".btn_evaluation a").click
          current_path.should == new_sp_ticket_review_path(@purchase.ticket)
        end

        it "購入したチケットに既にレビューしていたら評価するリンクが表示されないこと" do
          FactoryGirl.create(:review, :user => user, :ticket => @ticket)
          # spのマイページにアクセス
          visit sp_home_path 
          # [評価する]リンクがないこと
          page.should_not have_css(".ico_eva") 
        end
      end

      context "購入したチケットがない場合" do
        it "購入チケットがない旨が表示されること" do
          visit sp_home_path
          find(".txt_tkt_info").should have_content("購入したチケットはありません。")
        end
      end
    end
  end
end
