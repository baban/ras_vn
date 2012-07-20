# encoding: utf-8
require 'spec_helper'

describe Notifications::Favorite do
  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:favorite) { create(:favorite, :user => user, :ticket => create(:opening_ticket, :user => user2)) }

    subject { Notifications::Favorite.perform(favorite.id) }

    before do
      @notification = create(:favorite_notification, :user => user, :recipient_user => user2, :resource_id => favorite.id)
      @notification.stub(:mail_notify?).and_return(true)
      Notifications::Favorite.stub(:find_by_resource_id).and_return(@notification)
    end

    context "ユーザーにメールが送信可能であれば" do
      before do
        Notifier.should_receive(:favorited).with(@notification).and_return(mail)
      end

      it "LOVE通知メールを送信していること" do
        subject
      end

      it "LOVE通知メール履歴を保存していること" do
        @notification.should_receive(:set_send_mail_timer).and_return(nil)
        subject
      end
    end

    context "ユーザーにメール送信不可能な場合" do
      before do
        @notification.stub(:mail_notify?).and_return(false)
        @notification.should_not_receive(:set_send_mail).and_return(mail)
        Notifications::Favorite.stub(:find_by_resource_id).and_return(@notification)
      end

      it "LOVE通知メールを送信しないこと" do
        Notifier.should_not_receive(:favorited).with(@notification).and_return(nil)
        subject
      end
    end
  end

  describe ".create_from!" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:favorite) { build(:favorite, :user => user, :ticket => create(:opening_ticket, :user => user2)) } 
    context "LOVEされたチケット出品者とLOVEしたユーザが同じなら" do
      let(:user2) { user }
      it "通知を作成しないこと" do
        expect { Notifications::Favorite.create_from!(favorite) }.to_not change(Notifications::Favorite, :count).by(1)
      end
    end

    context "LOVEされたチケット出品者とLOVEしたユーザが異なるなら" do
      it "通知を作成すること" do
        expect { Notifications::Favorite.create_from!(favorite) }.to change(Notifications::Favorite, :count).by(1)
      end
    end
  end
end
