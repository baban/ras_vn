# encoding: utf-8
require 'spec_helper'

describe "Header Notifications" do
  describe "GET /" do
    # ログインする
    include_context "capybara_login"

    before do
      @user1 = user
      @user2 = FactoryGirl.create(:exhibited_user)
      @ticket = FactoryGirl.create(:opening_ticket, :user => @user1)
    end
      
    it "お知らせ情報が一件もない場合、「お知らせ情報はありません」が表示される", :js => true do
      # js が効かない場合に呼ばれる下記ページへと遷移 
      visit notifications_path 

      # お知らせ情報が一件もない場合
      within "li.head_news" do
        page.should have_no_content("お知らせ情報はありません。")
        page.should have_content("NEWS")
      end
      click_link "NEWS"
      page.should have_content("お知らせ情報はありません。")

    end

    #it "お知らせアイコンから、お知らせ一覧が閲覧できること", :js => true do
    it "フォローされたお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      FactoryGirl.create(:friendship, :user => @user2, :friend => @user1)
      visit notifications_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@user2.name+"さんがあなたをフォローしました")
      end
    end

    it "メッセージのお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      conversation = FactoryGirl.create(:conversation)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user1) 
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2)
      message = FactoryGirl.create(:message, :conversation => conversation, :user => @user2, :to_user => @user1)
      FactoryGirl.create(:message_notification, :user => @user2, :recipient_user => @user1, :resource_id => message.id)
      visit root_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@user2.name+"さんからメッセージが届きました")
      end
    end

    it "ボードのコメントののお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      note = FactoryGirl.create(:note, :user => @user1)
      FactoryGirl.create(:note_comment, :note => note, :user => @user2)
      visit notifications_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@user2.name+"さんがあなたのボードにコメントをしました")
      end
    end

    it "購入のコメントののお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      FactoryGirl.create(:purchase, :user => @user2, :ticket => @ticket, :cost => @ticket.price)
      visit root_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@user2.name+"さんが"+@ticket.title+"を購入しました")
      end
    end

    it "チケットの採用のお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      ticket2 = FactoryGirl.create(:examining_ticket, :user => @user1)
      ticket2.open!
      visit root_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@ticket.title+"が採用されました")
      end
    end

    it "チケットの不採用のお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      ticket2 = FactoryGirl.create(:examining_ticket, :user => @user1)
      reject = FactoryGirl.create(:rejection_ticket, :ticket => ticket2)
      ticket2.reject!(reject)
      visit root_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@ticket.title+"の審査結果が届きました")
      end
    end

    it "チケットの承認・否認関係のお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      FactoryGirl.create(:review, :ticket => @ticket)
      visit notifications_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content(@user2.name+"さんが"+@ticket.title+"のレビューを投稿しました")
      end
    end

    it "出品者採用のお知らせがある場合、お知らせ一覧から閲覧できること", :js => true do
      # ちょっと楽しちゃう
      FactoryGirl.create(:user_notification, :user => @user2, :recipient_user => @user1)
      visit notifications_path 
      click_link "NEWS"
      within "li.head_news" do
        page.should have_content("出品者として採用されました")
      end
    end
  end

end
