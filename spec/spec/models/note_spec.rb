# encoding: utf-8
require 'spec_helper'

describe Note do
  describe "#deletable?" do
    before do
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => @user)
    end

    context "ノートを書いたユーザーと引数のユーザーが同じ場合" do
      it "trueになること" do
        @note.deletable?(@user).should be_true 
      end 
    end  

    context "ノートを書いたユーザーと引数のユーザーが異なる場合" do
      it "falseになること" do
        @note.deletable?(@user2).should be_false
      end
    end
  end

  describe "#comment_users_ids(user)" do
    before do
      user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      user3 = FactoryGirl.create(:user)
      user4 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => user)
      FactoryGirl.create(:note_comment, :user => @user2, :note => @note)
      FactoryGirl.create(:note_comment, :user => user3, :note => @note)
      FactoryGirl.create(:note_comment, :user => user4, :note => @note)
    end
    it "コメントしている他のユーザーのID一覧が返ること" do
      @note.comment_users_ids(@user2).size.should == 2
    end
  end

  describe ":in_reply_to" do
    context "他人がボードに投稿した場合" do
      before do
        @user = create(:user)
        create(:note, :user => @user)
        create(:note, :in_reply_to_user => @user)
      end
      subject { Note.in_reply_to(@user) }

      it "自分宛のボードも取得すること" do
        should have(2).items
      end
    end
  end
end
