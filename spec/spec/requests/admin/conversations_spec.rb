# encoding: utf-8
require 'spec_helper'

describe "Admin::Conversations" do

  describe "GET /admin/messages" do
    # ログインする
    include_context "capybara_login"
    let(:user) { FactoryGirl.create(:admin_user) }

    before do
      # メッセージの作成
      conversation = FactoryGirl.create(:conversation)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 
      @message = FactoryGirl.create(:message, :conversation => conversation, :user => user, :to_user => @user2) 
    end

    it "メッセージ詳細が表示されること" do
      visit admin_conversation_path(@message.conversation)

      # メッセージ一覧が表示されていること
      page.should have_content("メッセージ一覧")

      # メッセージが表示されていること
      page.should have_content(@message.body) 
      page.should have_content("削除")

    end
  end

end
