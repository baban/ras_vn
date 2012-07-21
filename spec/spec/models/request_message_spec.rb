# -*- coding: utf-8 -*-
require 'spec_helper'

describe RequestMessage do
  describe "#want(user)" do

    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:exhibited_user)
      @request_message = FactoryGirl.create(:request_message, :user => @user2)
    end
    it "ほしい！のカウントが１上がること" do
      expect {
        @request_message.want @user1
        @request_message.reload
      }.should change(@request_message, :wants_count).by(1)
    end
  end

  describe "#unwant" do
    before do
      @user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:wanted_request_message, :user => user2)
      @request_message.want @user1
      @request_message.reload
    end
    it "ほしい！のカウントが１下がること" do
      expect {
        @request_message.unwant @user1
        @request_message.reload
      }.should change(@request_message, :wants_count).by(-1)
    end
  end

  describe "#wanted?(user)" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:wanted_request_message, :user => @user2)
      @request_message.want @user1
    end
    context "既に「ほしい！」をしていれば" do
      it "trueが返ること" do
        @request_message.wanted?(@user1).should be_true
      end
    end
    context "まだ「ほしい！」をしていなければ" do
      it "falseが返ること" do
        @request_message.wanted?(@user2).should be_false
      end
    end
  end

  describe "#own?" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:wanted_request_message, :user => @user2)
      @request_message.want @user1
    end
    context "リクエストをした本人であれば" do
      it "trueが返ること" do
        @request_message.own?(@user2).should be_true
      end
    end
    context "リクエストをした本人でなければ" do
      it "falseが返ること" do
        @request_message.own?(@user1).should be_false
      end
    end
  end

  describe "#responded_tickets" do
    before do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:request_message, :user => user2)
      2.times do
        FactoryGirl.create(:opening_ticket, :user => user, :request_message => @request_message)
      end
    end
    it "リクエストに応えたチケットで、公開状態でストックがあるものが取得できること" do
      @request_message.responded_tickets.count.should == 2
    end
  end

end
