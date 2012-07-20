# encoding: utf-8
require 'spec_helper'

describe "Sp::ReviewsController" do
  describe "GET /sp/tickets/:id/reviews/new" do
    context "未ログイン時に" do
      before do
        Capybara.current_driver = :sp
        @user = FactoryGirl.create(:user)
        @user2 = FactoryGirl.create(:user)
        @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
        @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => @user)
      end

      it "sp版のサインインのページに飛ばされること" do
        visit new_sp_ticket_review_path(@purchase.ticket)
        current_path.should == sp_signin_path
      end
    end

    context "ログイン済の時に" do
      include_context "capybara_sp_login"

      context "購入したチケットがある場合" do
        before do
          @user2 = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
          @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => user)
        end

        it "レビューがまだの購入したチケットにレビューができること" do
          # sp版のレビュー作成ページにアクセス
          visit new_sp_ticket_review_path(@purchase.ticket)
          # レビュー内容を入力して、画面遷移
          fill_in "review_description", :with => "" 
          find("input.btn_send_review").click

          # バリデーションにひっかかって戻ってくる
          find("h3.ml5").should have_content("チケットのレビュー")
          page.should have_content("本文を入力してください。")
          
          # 再度入力
          fill_in "review_description", :with => "hogehogehogehoge" 
          select( "5", :from => "review_rating")
          find("input.btn_send_review").click

          # レビュー投稿後sp版のチケット詳細ページに遷移し、レビューも投稿されていること
          current_path.should == sp_ticket_path(@ticket)
          page.should have_content("レビュー")
          find("p.review_txt").should have_content("hogehogehogehoge")
        end

        it "レビュー済の購入したチケットにレビューしようとしたらチケット詳細ページにとばされること" do
          FactoryGirl.create(:review, :user => user, :ticket => @ticket)
          # sp版のレビュー作成ページにアクセスしようとしたら詳細ページにとばされること
          visit new_sp_ticket_review_path(@purchase.ticket)
          current_path.should == sp_ticket_path(@ticket)
        end
      end

      context "購入したチケットがない場合" do
        it "URL直打ちでアクセスしようとしてもチケット詳細ページが表示されること" do
          @user = FactoryGirl.create(:user)
          @user2 = FactoryGirl.create(:user)
          @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
          @purchase = FactoryGirl.create(:purchase, :ticket => @ticket, :user => @user)
          
          visit new_sp_ticket_review_path(@purchase.ticket)
          current_path.should == sp_ticket_path(@ticket)
        end
      end
    end
  end
end
