# encoding: utf-8
require 'spec_helper'

describe "Welcomes" do
  describe "GET /" do
    context "チケットが一件もない場合" do
      it "ページが表示されること" do
        visit root_path
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
        visit root_path
        page.should have_content(@top_sale.title)
        page.should have_selector(".box_reg")
      end
      
      it "チケットをお気に入りできること", :js => true do
        visit root_path 
        within(".box_reg") do
          find(".arigato_count").should have_content "0"
          page.should have_content("LOVE") 
          
          find(".favorite").click
          find(".arigato_count").should have_content "1"
          
          find(".unfavorite").click
          find(".arigato_count").should have_content "0"
        end
      end
    end
  end
end
