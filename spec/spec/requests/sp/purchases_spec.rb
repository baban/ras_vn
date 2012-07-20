# encoding: utf-8
require 'spec_helper'
Capybara.current_driver = :sp

describe "Purchases" do

  describe "GET /sp/tickets/:id/purchases/new" do
    # ログインする
    include_context "capybara_sp_login"
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
            visit sp_ticket_path(@ticket)
            find(".btn_buy a").click
            page.should have_content(@ticket.title)
            fill_in "credit_number", :with => "1111222233334444"
            fill_in "credit_security_code", :with => "123"
            click_button "確認"
            page.should have_content("お支払い内容の確認")
            click_button "購入する"
            page.should have_content("購入しました。")
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
            visit sp_ticket_path(@ticket)
            find(".btn_buy a").click
            page.should have_content(@ticket.title)
            fill_in "credit_number", :with => "1111222233334444"
            fill_in "credit_security_code", :with => "123"
            click_button "確認"
              page.should have_content("入力項目に誤りがあります")
          end
        end
      end

      context "最終ログインが１時間以上前なら" do
        it "パスワード確認を挟んで購入画面が表示されること" do
          visit sp_ticket_path(@ticket)
          user.last_login_at = 2.hours.ago
          user.save
          find(".btn_buy a").click
          page.should have_content("パスワード確認")
          fill_in "user_current_password", :with => user.password
          click_button "確認する"
          page.should have_content(@ticket.title)
        end
      end
    end
  end
end
