# encoding: utf-8
require 'spec_helper'

describe "Sp::ReviewsController" do
  describe "GET /sp/tickets/:id/reviews/new" do
    include_context "capybara_sp_login"

    context "ユーザーが存在していて" do
      context "チケットを出品したユーザーのページにアクセスした場合" do
        before do
          @user2 = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
        end

        it "出品しているチケットが表示されること" do
          visit sp_user_path(@user2.url_name)
          find("p.txt_tkt_info").should have_content @ticket.title
        end
      end

      context "チケットを出品していないユーザーのページにアクセスした場合" do
        it "出品されたチケットがない旨が表示されること" do
          @user2 = FactoryGirl.create(:user)
          
          visit sp_user_path(@user2.url_name)
          find("p.txt_tkt_info").should have_content "出品されたチケットがありません"
        end
      end
    end
  end
end
