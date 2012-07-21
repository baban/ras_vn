# encoding: utf-8
require 'spec_helper'

describe Notifications::Want do
  describe "#want" do
    before do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      request_message = FactoryGirl.create(:request_message, :to_user => user2)
      @want = FactoryGirl.create(:want, :request_message => request_message, :user => user)
      @notification = Notifications::Want.find_by_resource_id @want.id
    end

    it "wantのインスタンスが返ること" do
      @notification.want.should == @want
    end
  end

  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:want) { create(:want, :user => user, :request_message => create(:request_message, :user => user, :to_user => user2))}

    subject { Notifications::Want.perform(want.id) }

    before do
      @notification = create(:want_notification, :user => user, :recipient_user => user2, :resource_id => want.id)
      Notifications::Want.stub(:find_by_resource_id).and_return(@notification)
    end

    context "ユーザーにメールが送信可能で" do
      it "通知メールを送信していること" do
        @notification.stub(:mail_notify?).and_return(true)
        Notifier.should_receive(:requested).with(@notification).and_return(mail)
        subject
      end

      it "通知メール履歴を保存していること" do
        @notification.should_receive(:set_send_mail_timer).and_return(nil)
        subject
      end
    end
  end

  describe ".create_from!" do
    before do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      request_message = FactoryGirl.create(:request_message, :to_user => user2)
      request_message2 = FactoryGirl.create(:request_message)
      @want = FactoryGirl.create(:want, :request_message => request_message, :user => user)
      @want2 = FactoryGirl.create(:want, :request_message => request_message2, :user => user)
    end

    it "Notificationにデータが一件増えること" do
      expect {
        Notifications::Want.create_from!(@want) 
      }.should change(Notification, :count).by(1)
    end

    it "みんなに対するリクエストに対してほしいを行っても、Notificationにデータが増えないこと" do
      expect {
        Notifications::Want.create_from!(@want2) 
      }.should change(Notification, :count).by(0)
    end
  end
end
