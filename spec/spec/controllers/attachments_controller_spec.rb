# encoding: utf-8
require 'spec_helper'
require 'support/database_cleaner_context'

describe AttachmentsController do

  describe "GET 'new'" do
    context "ログインしていなかったら" do
      let(:ticket) { FactoryGirl.create(:ticket) }
      it "ログイン画面にリダイレクトされること" do
        get :new, :ticket_id => ticket
        response.should redirect_to(signin_path)
      end  
    end  

    context "ログインしていて" do
      include_context "ログインする"

      context "チケット登録者の場合" do
        let(:ticket) { FactoryGirl.create(:ticket, :user => user) }
        before do
          13.times do
            FactoryGirl.create(:attachment, :user => user, :ticket => ticket)
          end
        end

        it "チケット登録画面へと遷移すること" do
          get :new, :ticket_id => ticket
          response.should be_success 
        end

        it "添付画像が一覧で10件まで表示されること" do
          get :new, :ticket_id => ticket.id
          assigns[:attachments].should have(10).items 
        end
      end

      context "チケット登録者でない場合" do
        let(:ticket) { FactoryGirl.create(:ticket) }
        it "チケット登録画面へと遷移すること" do
          get :new, :ticket_id => ticket.id
          response.should redirect_to(root_path)
        end
      end
    end
  end
end
