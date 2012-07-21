# encoding: utf-8
require 'spec_helper'

describe Notifications::User do
  describe ".perform" do
    include_context "mock_mailer"
    before do
      @user = create(:user)
      @notification = create(:user_notification, :user => @user, :recipient_user => @user, :resource_id => @user.id)
      @user.stub(:mail_receivable?).and_return(true)
    end

    it "ユーザ出品者登録完了メールを送信していること" do
      Notifier.should_receive(:adopted_as_exhibitor).with(@notification).and_return(mail)
      Notifications::User.perform(@user.id)
    end
  end

  describe ".before_update_from!" do
    before do
      @user = FactoryGirl.create(:user)
      @user.stub(:exhibitor_flag_changed?).and_return(true)
    end

    it "Notificationにデータが一件増えること" do
      expect {
        Notifications::User.before_update_from!(@user)
      }.should change(Notification, :count).by(1)
    end
  end
end
