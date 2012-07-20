# encoding: utf-8
require 'spec_helper'

describe Notification do
  describe "#partial" do
    before do
      @user = FactoryGirl.create(:user)
      @activity = @user.notifications.build
    end

    it "notifications/notificationが返ること" do
      @activity.partial.should == "notifications/notification" 
    end
  end

  describe "#increase_notifications_count" do
    pending "あとで"
=begin
    before do
      user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @notification = FactoryGirl.create(:purchase_notification, :user => user1, :recipient_user => @user2)
    end
    it "お知らせされるuserのお知らせ数が1増えていること" do
      expect {
        @notification.increase_notifications_count
      }.should change(@user2, :notifications_count)
    end
=end
  end

  describe ".queue" do
    it ":abilieが返ること" do
      Notification.queue.should == :abilie
    end  
  end

  describe ".child_class" do
    it "Purchaseを引数に渡すと、Notification::Purchaseクラスが返ること" do
      Notification.child_class("Purchase").should == Notifications::Purchase
    end
  end

  describe "#set_send_mail_timer" do
    before do
      @redis = Abilie::Redis.connection
      favorite = create(:favorite)
      notification = create(:favorite_notification, :resource_id => favorite.id)
      @send_mail_key = notification.send(:create_send_mail_key)
      notification.set_send_mail_timer
    end
    it "redisにメール送信履歴が登録されること" do
      @redis.get(@send_mail_key).should be_present
    end
    it "expire_time が設定されていること" do
      @redis.ttl(@send_mail_key).should be_present
    end
  end

  describe "mail_notify?" do
    let(:user) { create(:notification_setting_user) }
    let(:favorite) { create(:favorite, :ticket => create(:ticket, :user => user)) }
    let(:notification) { create(:favorite_notification, :recipient_user => user, :resource_id => favorite.id) }
    subject { notification.mail_notify? }

    context "ユーザーのメールアドレスが受信不可の場合" do
      before do
        user.stub(:mail_receivable?).and_return(false)
      end

      it { should be_false } 
    end

    context "ユーザーがメールを受信可能で" do
      before do
        user.stub(:mail_receivable?).and_return(true)
      end

      context "通知設定が保存されていない場合" do
        let(:user) { create(:user) }

        it { should be_true }
      end

      context "通知設定が保存されていて" do
        let(:user) { create(:notification_setting_user) }
        context "通知拒否の場合" do
          it { should be_false }
        end

        context "通知OKの場合" do
          let(:notification) { create(:friendship_notification, :recipient_user => user) }
          it { should be_true }
        end
      end
    end
  end
end
