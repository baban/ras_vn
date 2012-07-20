# encoding: utf-8
require 'spec_helper'

describe Conversation do
  let(:conversation) { FactoryGirl.create(:conversation) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  before do
    FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user1)
    FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2)
  end

  describe "#companion" do
    subject { conversation.companion(user) }

    context "メッセージ交換可能なユーザーがいれば" do
      let(:user) { user1 }

      it "userが返ること" do
        should == user2
      end     
    end

    context "conversation_membersが空であれば" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        conversation.conversation_members = []
        conversation.save
      end

      it "nilが返ること" do
        should be_nil
      end     
    end
  end

  describe "#recent_message" do
    before do 
      5.times do |n|
        FactoryGirl.create(:message, :conversation => conversation, :user => user1, :to_user => user2)
      end
    end

    it "conversationのメッセージの中で最新のメッセージが一件取得できること" do
      conversation.recent_message.should be_an_instance_of(Message)
    end
  end

  describe ".relate_messages" do
    subject { Conversation.relate_messages(user) }

    context "conversationにデータがあり、且つメッセージがあれば" do
      let(:user) { FactoryGirl.create(:user)}

      before do 
        4.times do
          conversation = FactoryGirl.create(:conversation)
          user2 = FactoryGirl.create(:user)
          FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
          FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2) 
          FactoryGirl.create(:message, :conversation => conversation, :user => user, :to_user => user2) 
        end
      end
      it "関連するメッセージが取得できること" do
        should have(4).items
      end
    end
    context "conversationにデータがあっても、メッセージがなければ" do
      let(:user) {FactoryGirl.create(:user)}
      before do 
        4.times do
          conversation = FactoryGirl.create(:conversation)
          user2 = FactoryGirl.create(:user)
          FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
          FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2) 
        end
      end
      it "件数が０件であること" do
        should have(0).item
      end
    end
  end

  describe "#exhibitor?" do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket) }
    let(:purchase) { create(:purchase, :ticket => ticket) }
    let(:conversation) { create(:conversation, :purchase => purchase) }

    subject { conversation.exhibitor? user }

    context "出品者と指定したユーザーが異なる場合" do
      it { should be_false }
    end

    context "出品者と指定したユーザーが同じ場合" do
      let(:ticket) { create(:ticket, :user => user) }
      it { should be_true }
    end
  end
end
