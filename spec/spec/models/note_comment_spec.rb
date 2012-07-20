# encoding: utf-8
require 'spec_helper'


describe NoteComment do
  let(:note_creator) { FactoryGirl.create(:user) }
  let(:commentor) { FactoryGirl.create(:user) }
  let(:note) { FactoryGirl.create(:note, :user => note_creator) }
  let(:note_comment) { FactoryGirl.create(:note_comment, :note => note, :user => commentor) }

  describe "#deletable" do
    subject { note_comment.deletable?(user) }

    context "コメント作成者と引数のuserが同じであれば" do
      let(:user) { commentor }

      it "trueになること" do
        should be_true
      end 
    end    

    context "コメント作成者と引数のuserが異なる場合" do
      let(:user) { FactoryGirl.create(:user) }

      it "falseになること" do
        should be_false 
      end
    end
  end

  describe "#notificate?" do
    subject { note_comment.notificate? }

    context "コメント作成者とノート作成者が同じであれば" do
      let(:note_comment) { FactoryGirl.create(:note_comment, :note => note, :user => note_creator) }
      it "falseになること" do
        should be_false 
      end 
    end    

    context "コメント作成者とノート作成者が異なれば" do
      it "trueになること" do
        should be_true 
      end
    end
  end
end
