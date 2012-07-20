# encoding: utf-8
require 'spec_helper'

describe Notifications::Review do
  describe "#ticket" do
    before do
      @ticket = FactoryGirl.create(:ticket)
      @user = FactoryGirl.create(:user)
      @review = FactoryGirl.create(:review, :ticket => @ticket, :user => @user)
      @notification = Notifications::Review.find_by_resource_id @review.id
    end
  
      
    it "Ticketのインスタンスが返ること" do
      @notification.ticket.should == @ticket      
    end
  end

  describe ".create_from!" do
    before do
      @ticket = FactoryGirl.create(:ticket)
      @user = FactoryGirl.create(:user)
      @review = FactoryGirl.create(:review, :ticket => @ticket, :user => @user)
    end

    it "Notificationにデータが一件増えること" do
      expect {
        Notifications::Review.create_from!(@review)
      }.should change(Notification, :count).by(1)
    end
  end

  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:review) { create(:review, :user => user, :ticket => create(:ticket, :user => user2)) }
    
    subject { Notifications::Review.perform(review.id) }

    before do
      @notification = create(:review_notification, :user => user, :recipient_user => user2, :resource_id => review.id)
      Notifications::Review.stub(:find_by_resource_id).and_return(@notification)
    end

    it "レビューメールを送信していること" do
      Notifier.should_receive(:reviewed).with(@notification).and_return(mail)
      subject
    end
  end
end
