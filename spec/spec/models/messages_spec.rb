# encoding: utf-8
require 'spec_helper'

describe Message do
  let(:conversation) { FactoryGirl.create(:conversation) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:conversation_member1) { FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user1) }
  let(:conversation_member2) { FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user2) }
  let(:message) { FactoryGirl.create(:message, :conversation => conversation, :user => user1, :to_user => user2)} 

  describe "#read" do
    let(:message) { FactoryGirl.create(:message, :conversation => conversation, :user => user1, :to_user => user2)} 
    subject { message.read(user) }

    context "メッセージ受信者と、指定したユーザーが異なる場合" do
      let(:user) { FactoryGirl.create(:user) }
      it "nilが返ること" do
        should be_nil 
      end
    end

    context "既読(read_flag == true)であれば" do
      let(:message) { FactoryGirl.create(:read_message, :conversation => conversation, :user => user1, :to_user => user2)} 
      let(:user) { user2 }

      it "nilが返ること" do
        should be_nil
      end
    end 

    context "未読のメッセージで、受信者と指定したユーザーが同じであれば" do
      let(:user) { user2 }
      it "trueが返ること" do
        should be_true 
      end 

      it "既読(read_flag == true)になること" do
        expect { 
          subject
        }.should change(message, :read_flag).from(false).to(true)
      end
    end
  end
  describe "#deletable" do
    subject { message.deletable?(user) }
    
    context "メッセージ受信者と、指定したユーザーが同じであれば" do
      let(:user) { user1 }

      it "trueが返ること" do
        should be_true 
      end 
    end

    context "メッセージ受信者と、指定したユーザーが異なる場合" do
      let(:user) { user2 }

      it "falseが返ること" do
        should be_false 
      end 
    end
  end

  describe "#extension_white_list" do
    subject { Message.new.extension_white_list }

    it "文字列が返ること" do
      should be_an_instance_of String   
    end
  end
end
