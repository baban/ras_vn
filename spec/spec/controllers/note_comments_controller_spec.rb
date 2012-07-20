# encoding: utf-8
require 'spec_helper'
require 'support/before_login_context'
require 'support/database_cleaner_context'

describe NoteCommentsController do
  before(:all) do
    # コメントのため@noteを作成
    # (notes/:note_id/note_commentsにいくため)
    @note = FactoryGirl.create(:note)
  end

  include_context "database_cleaner"

  describe "POST create" do
    context "非ログインの場合" do
      it "ログイン画面にリダイレクトされること" do
        post :create, :note_comment => nil, :note_id => @note 
        response.should redirect_to(signin_path)
      end  
    end
    context "ログインして" do
      include_context "ログインする"
      let(:note_comment) { FactoryGirl.attributes_for(:note_comment) }

      context "正しいデータを送信した場合" do
        it "note_commentsテーブルにデータが登録されること" do
          expect {
            post :create, :note_comment => note_comment, :note_id => @note 
          }.to change(NoteComment, :count).by(1)
        end

        it "json の status.success のレスポンスが true であること" do
          pending "add some examples to (or delete) #{__FILE__}"
        end
      end
      context "不正なデータを送信した場合" do
        let(:note_comment) { FactoryGirl.attributes_for(:note_comment, :body => "") }
        before do
          post :create, :note_comment => note_comment, :note_id => @note 
        end

        it "note_commentsテーブルにデータが登録されないこと" do
          expect {
            post :create, :note_comment => note_comment, :note_id => @note 
          }.to change(NoteComment, :count).by(0)
        end

        it "json の status.success のレスポンスfalseであること" do
          pending "add some examples to (or delete) #{__FILE__}"
        end
      end
    end
  end

  describe "DELETE destroy" do

    context "ログインしていない場合" do
      before do
        # ログインしていないためuser_idを適当に1でコメントを作ったけどいいのだろうか
        @note_user = FactoryGirl.create(:user)
        @note_comment_user = FactoryGirl.create(:user)
        @note = FactoryGirl.create(:note, :user => @note_user)
        @note_comment = FactoryGirl.create(:note_comment, :user => @note_comment_user, :note => @note)
      end

      it "ログイン画面にリダイレクトされること" do
        delete :destroy, :note_id => @note, :id => @note_comment
        response.should redirect_to(signin_path)
      end
    end

    context "ログインしている場合" do
      include_context "ログインする"

      before do
        @note_user = FactoryGirl.create(:user)
        @note = FactoryGirl.create(:note, :user => @note_user)
        @note_comment = FactoryGirl.create(:note_comment, :user => user, :note => @note)
      end

      it "コメントが削除されること" do
        expect {
          delete :destroy, :note_id => @note, :id => @note_comment
        }.to change(NoteComment, :count).by(-1)
      end

      it "ボード詳細ページにリダイレクトされること" do
        delete :destroy, :note_id => @note, :id => @note_comment
        response.should redirect_to user_note_path(@note.user.url_name, @note)
      end
    end 
  end

end
