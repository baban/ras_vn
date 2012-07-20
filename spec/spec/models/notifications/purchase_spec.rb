# encoding: utf-8
require 'spec_helper'

describe Notifications::Purchase do
  describe "#ticket" do
    before do
      @purchase = FactoryGirl.create(:purchase)
      @notification = Notifications::Purchase.find_by_resource_id @purchase.id
    end

    it "Ticketのインスタンスが返ること" do
      @notification.ticket.should == @purchase.ticket
    end
  end

  describe ".create_from!" do
    before { @purchase = FactoryGirl.create(:purchase) }

    it "Notificationにデータが一件増えること" do
      expect {
        Notifications::Purchase.create_from!(@purchase)
      }.should change(Notification, :count).by(1)
    end
  end

  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:purchase) { create(:purchase, :user => user, :ticket => create(:ticket, :user => user2)) }
    
    subject { Notifications::Purchase.perform(purchase.id) }

    before do
      @notification = create(:purchase_notification, :user => user, :recipient_user => user2, :resource_id => purchase.id)
      Notifications::Purchase.stub(:find_by_resource_id).and_return(@notification)
    end

    it "購入メールを送信していること" do
      Notifier.should_receive(:purchase).with(@notification).and_return(mail)
      subject
    end
    it "購入メールを送信していること" do
      Notifier.should_receive(:purchased).with(@notification).and_return(mail)
      subject
    end
  end
end
