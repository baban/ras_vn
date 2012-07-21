# encoding: utf-8
require 'spec_helper'

describe "AbilieStream" do

  describe "GET /stream" do

    # ログインする
    include_context "capybara_login"

    it "アクティビティがあること" do
      purchase = FactoryGirl.create(:purchase)
      
      visit stream_activities_path
      within("ul.prf_act") do
        page.should_not have_content("何もアクティビティがありません")
      end
    end
    
    it "アクティビティがないこと" do
      visit stream_activities_path
      page.should have_content("何もアクティビティがありません")
    end
  end

  describe "GET /ticket" do

    # ログインする
    include_context "capybara_login"

    it "出品のアクティビティがあること" do
      ticket = FactoryGirl.create(:opening_ticket)
      
      visit ticket_activities_path
      within("ul.prf_act") do
        page.should have_content("出品しました")
      end
    end
    
    it "出品のアクティビティがないこと" do
      visit ticket_activities_path
      page.should have_content("何もアクティビティがありません")
    end
  end
  
  describe "GET /purchase" do

    # ログインする
    include_context "capybara_login"

    it "購入のアクティビティがあること" do
      purchase = FactoryGirl.create(:purchase)
      
      visit purchase_activities_path
      within("ul.prf_act") do
        page.should have_content("購入されました")
      end
    end
    
    it "購入のアクティビティがないこと" do
      visit purchase_activities_path
      page.should have_content("何もアクティビティがありません")
    end
  end

  describe "GET /board" do

    # ログインする
    include_context "capybara_login"

    it "ボードのアクティビティがあること" do
      user2 = FactoryGirl.create(:user)
      note = FactoryGirl.create(:note, :user => user2)
      
      visit board_activities_path
      within("ul.prf_act") do
        page.should have_content("呟きました")
      end
    end
    
    it "ボードの返信のアクティビティがあること" do
      user2 = FactoryGirl.create(:user)
      note = FactoryGirl.create(:note, :user => user2)
      note_comment = FactoryGirl.create(:note_comment, :note => note, :user => user)
      
      visit board_activities_path
      within("ul.prf_act") do
        page.should have_content("返信しました")
      end
    end

    it "ボードのアクティビティがないこと" do
      visit board_activities_path
      page.should have_content("何もアクティビティがありません")
    end
  end

  describe "GET /review" do

    # ログインする
    include_context "capybara_login"

    it "レビューのアクティビティがあること" do
      ticket = FactoryGirl.create(:ticket)
      review = FactoryGirl.create(:review, :user => user, :ticket => ticket) 
      
      visit review_activities_path
      within("ul.prf_act") do
        page.should have_content("レビューを投稿しました")
      end
    end
    
    it "レビューのアクティビティがないこと" do
      visit review_activities_path
      page.should have_content("何もアクティビティがありません")
    end
  end

  describe "GET /request_message" do
    # ログインする
    include_context "capybara_login"

    it "リクエストのアクティビティがあること" do
      user2 = FactoryGirl.create(:user)
      request_message = FactoryGirl.create(:request_message, :user => user2)
      
      visit stream_activities_path
      within("ul.prf_act") do
        page.should have_content("リクエストをしました")
      end
    end
    
    it "リクエストのアクティビティがないこと" do
      visit stream_activities_path
      page.should have_content("何もアクティビティがありません")
    end
  end
end
