# encoding: utf-8
require 'spec_helper'

describe Admin::MessagesController do
  describe "PUT open" do
    # ログインする
    include_context "ログインする"
    let(:user) { FactoryGirl.create(:admin_user) }

    before do
      # メッセージの作成
      conversation = FactoryGirl.create(:conversation)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 
      @message = FactoryGirl.create(:message, :conversation => conversation, :user => user, :to_user => @user2, :delete_flag => true) 
    end

    it "メッセージが公開状態になること" do
      put :open, :id => @message
      @message.delete_flag.should be_true

    end
  end

  describe "DELETE destroy" do
    # ログインする
    include_context "ログインする"
    let(:user) { FactoryGirl.create(:admin_user) }

    before do
      # メッセージの作成
      conversation = FactoryGirl.create(:conversation)
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 
      @message = FactoryGirl.create(:message, :conversation => conversation, :user => user, :to_user => @user2) 
    end

    it "メッセージが削除状態になること" do
      delete :destroy, :id => @message
      @message.delete_flag.should be_false
    end
  end
end
