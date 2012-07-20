# encoding: utf-8
require 'spec_helper'

describe Notifications::Note do
  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    subject { Notifications::Note.perform(note.id) }

    context "mail_receivable?がtrueの場合" do
      before { user2.stub(:mail_receivable?).and_return(true) }

      context "チケットにコメントされた場合" do
        let(:note) { create(:note, :user => user, :in_reply_to_user => user2, :ticket => create(:opening_ticket, :user => user)) }
        before do
          @notification = create(:note_notification, :user => user, :recipient_user => user2, :resource_id => note.id)
          Notifications::Note.stub(:find_by_resource_id).with(note.id).and_return(@notification)
        end

        it "チケットコメント通知メールを送信していること" do
          Notifier.should_receive(:ticket_commented).with(@notification).and_return(mail)
          subject
        end
      end

      context "ボード投稿に投稿された場合" do
        let(:note) { create(:note, :user => user, :in_reply_to_user => user2, :ticket => nil) }
        before do
          @notification = create(:note_notification, :user => user, :recipient_user => user2, :resource_id => note.id)
          Notifications::Note.stub(:find_by_resource_id).and_return(@notification)
        end
        
        it "ボード投稿通知メールを送信していること" do
          Notifier.should_receive(:posted_board).with(@notification).and_return(mail)
          subject
        end
      end
    end
  end

  describe ".create_from!" do
    context "チケットにコメントされた場合" do
      before { @note = build(:note, :user => create(:user), :in_reply_to_user => create(:user), :ticket => create(:opening_ticket)) }
      it "通知を作成すること" do
        expect { Notifications::Note.create_from!(@note) }.to change(Notifications::Note, :count).by(1)
      end
    end

    context "ボードに投稿された場合" do
      before { @note = build(:note, :user => create(:user), :in_reply_to_user => create(:user)) }
      it "通知を作成すること" do
        expect { Notifications::Note.create_from!(@note) }.to change(Notifications::Note, :count).by(1)
      end
    end

    context "ボードに投稿した場合" do
      before { @note = build(:note, :user => create(:user)) }
      it "通知を作成しないこと" do
        expect { Notifications::Note.create_from!(@note) }.to_not change(Notifications::Note, :count).by(1)
      end
    end
  end
end
