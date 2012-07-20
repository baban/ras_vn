# encoding: utf-8
require 'spec_helper'

describe "Purchases" do
  describe "GET /index" do

    # ログインする
    include_context "capybara_login"

    it "購入したチケットがあること" do
      @user2 = FactoryGirl.create(:user)
      ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
      purchase = FactoryGirl.create(:purchase, :ticket => ticket, :user => user)
      conversation = FactoryGirl.create(:conversation, :purchase => purchase)
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 

      visit purchases_path
      within("p.myp_ttl_area") do
        page.should have_content("hoge")
      end
    end

    it "購入チケットがないこと" do
      visit purchases_path
      page.should have_content("購入したチケットはありません。")
    end
  end

  describe "GET /tickets/:id/purchases/new" do
    # ログインする
    include_context "capybara_login"
    before do
      @ticket = FactoryGirl.create(:opening_ticket)
    end

    context "メール認証済みで" do
      context "最終ログインが１時間以内なら" do
        context "正しくカード情報を入力した場合" do
          before do
            response = mock(Sbps::Response)
            response.stub(:error?).and_return(false)
            response.stub(:body).and_return({"res_sps_transaction_id" => "456"})
            Sbps.stub(:settle).and_return(response)
            Sbps.stub(:commit).and_return(response)
          end
          
          it "商品が購入できること" do
            visit ticket_path(@ticket)
            find(".dtl_buy_btn a").click
            page.should have_content("#{@ticket.title} を購入します")
            fill_in "credit_number", :with => "1111222233334444"
            fill_in "credit_security_code", :with => "123"
            click_button "確認"
            page.should have_content("ご購入内容の確認")
            click_button "購入する"
            page.should have_content("ご購入は正常に完了しました。")
          end
        end

        context "クレジットカード情報に誤りがある場合" do
          before do
            response = mock(Sbps::Response)
            response.stub(:error?).and_return(true)
            response.stub(:error).and_return("test error")
            response.stub(:error_type).and_return(19)
            Sbps.stub(:settle).and_return(response)
          end

          it "エラーが表示されること" do
            visit ticket_path(@ticket)
            find(".dtl_buy_btn a").click
            page.should have_content("#{@ticket.title} を購入します")
            fill_in "credit_number", :with => "1111222233334444"
            fill_in "credit_security_code", :with => "123"
            click_button "確認"
            within(".errbg") do
              page.should have_content("入力項目に誤りがあります")
            end
          end
        end
      end

      context "最終ログインが１時間以上前なら" do
        it "パスワード確認を挟んで購入画面が表示されること" do
          visit ticket_path(@ticket)
          user.last_login_at = 2.hours.ago
          user.save
          find(".dtl_buy_btn a").click
          page.should have_content("パスワード確認")
          fill_in "user_current_password", :with => user.password
          click_button "確認する"
          page.should have_content("#{@ticket.title} を購入します")
        end
      end
    end
  end
end
