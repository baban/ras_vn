# encoding: utf-8
require 'spec_helper'

describe Notifications::Message do
  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:message) { create(:message, :user => user, :to_user => user2, :conversation => create(:conversation)) }

    subject { Notifications::Message.perform(message.id) }

    before do
      @notification = create(:message_notification, :user => user, :recipient_user => user2, :resource_id => message.id)
      Notifications::Message.stub(:find_by_resource_id).and_return(@notification)
    end

    context "ユーザーにメールが送信可能であれば" do
      it "メッセージ受信通知メールを送信していること" do
        Notifier.should_receive(:received_message).with(@notification).and_return(mail)
        subject
      end
    end
  end

  describe ".create_from!" do
    before do
      user = create(:user)
      user2 = create(:user)
      conversation = create(:conversation)
      conversation_members = create(:conversation_member, :conversation => conversation, :user => user2)
      @message = build(:message, :user => user, :to_user => user2, :conversation => conversation)
    end
    it "通知を作成すること" do
      expect { Notifications::Message.create_from!(@message) }.to change(Notifications::Message, :count).by(1)
    end
  end
end
