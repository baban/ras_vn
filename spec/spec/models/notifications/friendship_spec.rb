# encoding: utf-8
require 'spec_helper'

describe Notifications::Friendship do
  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:friendship) { create(:friendship, :user => user, :friend => user2) }

    subject { Notifications::Friendship.perform(friendship.id) }

    before do
      @notification = create(:friendship_notification, :user => user, :recipient_user => user2, :resource_id => friendship.id)
      Notifications::Friendship.stub(:find_by_resource_id).and_return(@notification)
    end

    context "ユーザーにメールが送信可能であれば" do
      before do
        @notification.stub(:mail_notify?).and_return(true)
        Notifier.should_receive(:followed).with(@notification).and_return(mail)
      end
      it "フォローメールを送信していること" do
        subject
      end
      it "フォローメール履歴を保存していること" do
        @notification.should_receive(:set_send_mail_timer).and_return(nil)
        subject
      end
    end

    context "ユーザーにメール送信不可能な場合" do
      before do
        @notification.stub(:mail_notify?).and_return(false)
        @notification.should_not_receive(:set_send_mail).and_return(mail)
        Notifications::Friendship.stub(:find_by_resource_id).and_return(@notification)
      end
      it "フォローメールを送信していないこと" do
        Notifier.should_not_receive(:followed).with(@notification)
        subject
      end
    end
  end

  describe ".create_from!" do
    let(:friendship) { build(:friendship, :user => create(:user), :friend => create(:user)) }
    it "通知を作成すること" do
      expect { Notifications::Friendship.create_from!(friendship) }.to change(Notifications::Friendship, :count).by(1)
    end
  end
end
