# encoding: utf-8
require 'spec_helper'

describe Notifications::NoteComment do
  describe "#note_comment" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => @user)
      @note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => @user2)
      @notification = Notifications::NoteComment.find_by_resource_id @note_comment.id
    end

    it "NoteCommentのインスタンスが返ること" do
      @notification.note_comment.should be_an_instance_of(NoteComment)
    end

    it "返り値が@note_commentであること" do
      @notification.note_comment.should == @note_comment
    end
  end

  describe ".create_from!" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => @user)
      @note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => @user2)
    end

    context "notification?がfalseの場合" do
      it "Notificaionが保存されないこと" do
        @note_comment.stub(:notificate?).and_return(false)
        expect {
          Notifications::NoteComment.create_from!(@note_comment)
        }.should_not change(Notification, :count).by(1)
      end
    end

    context "notification?がtrueの場合" do
      it "Notificaionが保存されること" do
        @note_comment.stub(:notificate?).and_return(true)
        expect {
          Notifications::NoteComment.create_from!(@note_comment)
        }.should change(Notification, :count).by(1)
      end
    end
  end

  describe ".perform" do
    include_context "mock_mailer"
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:note) { create(:note, :user => user) }
    let(:note_comment) { create(:note_comment, :note => note, :user => user2) }
    subject { Notifications::NoteComment.perform(note_comment.id) }

    before do
      @notification = create(:note_comment_notification, :user => user, :recipient_user => user2, :resource_id => note_comment.id)
      Notifications::NoteComment.stub(:find_by_resource_id).and_return(@notification)
    end
    context "notificate?がtrueの場合" do
      before { note_comment.stub(:notificate?).and_return(true) }
      context "mail_receivable?がtrueなら" do
        before { user2.stub(:mail_receivable?).and_return(true) }

        it "コメント通知メールを送信していること" do
          Notifier.should_receive(:commented).with(@notification).and_return(mail)
          subject
        end
      end
    end
  end
end
