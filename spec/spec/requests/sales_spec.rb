# encoding: utf-8
require 'spec_helper'

describe "Sales" do
  describe "GET /index" do

    # ログインする
    include_context "capybara_login"


    it "購入されたチケットがあること" do
      @user2 = FactoryGirl.create(:user)
      ticket = FactoryGirl.create(:opening_ticket, :user => user)
      sale = FactoryGirl.create(:purchase, :ticket => ticket, :user => @user2)
      conversation = FactoryGirl.create(:conversation, :purchase => sale)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 

      visit sales_path
      within("p.myp_ttl_area") do
        page.should have_content("hoge")
      end
    end

    it "購入されたチケットがないこと" do
      visit sales_path
      page.should have_content("購入されたチケットはありません。")
    end
  end
end
