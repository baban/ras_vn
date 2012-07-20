# encoding: utf-8
require 'spec_helper'
Capybara.current_driver = :sp

describe "Sp::Welcome" do
  describe "GET /sp" do
    context "チケットが一件もない場合" do
      it "ページが表示されること" do
        visit sp_root_path
        page.should have_content("Abilie[アビリエ]はあなたの知識やスキルを共有し、みんなに販売するサイト")
      end      
    end

    context "チケット、トップセールがある場合" do
      include_context "capybara_login"
      before do
        @top_sale = FactoryGirl.create(:top_sale_ticket)
        2.times do
          FactoryGirl.create(:hot_ticket)
        end

        11.times do
          FactoryGirl.create(:opening_ticket)
        end
      end

      it "ページが表示されること" do
        visit sp_root_path
        page.should have_content(@top_sale.title)
        page.should have_selector(".colum_ticket")
      end
      
      it "最近見たチケットが表示されること", :js => true do
        visit sp_root_path
        
        page.should have_no_content("最近見たチケット")
        page.should have_no_selector(".tkt")
        
        click_link @top_sale.title
        current_path.should == sp_ticket_path(@top_sale)
        visit sp_root_path
        
        page.should have_content("最近見たチケット")
        page.should have_selector(".tkt")
      end
    end
  end
end
