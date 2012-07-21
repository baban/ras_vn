# encoding: utf-8
require 'spec_helper'

describe "Tickets" do
  describe "GET /tickets/:id" do
    let(:ticket) { FactoryGirl.create(:opening_ticket) }

    context "販売中で" do
      let(:ticket) { FactoryGirl.create(:opening_ticket) }

      context "ログインしていない場合" do
        let(:url) { new_ticket_purchase_path(ticket) } 
        let(:image) { "/images/detail/buy_btn.gif" } 
        let(:image_bottom) { "/images/detail/buy_btn02.gif" } 

        it "購入するリンクがあること" do
          visit ticket_path(ticket)
          within("li.dtl_buy_btn") do
            page.should have_xpath("a[@href='#{url}']")
            page.should have_xpath("a//img[@src='#{image}']")
          end

          within(".dtl_buy_btn_btm") do
            page.should have_xpath("a[@href='#{url}']")
            page.should have_xpath("a//img[@src='#{image_bottom}']")
          end
        end 
      end  

      context "ログインしていて" do
        include_context 'capybara_login'

        context "自分のチケットの場合" do
          let(:ticket) { FactoryGirl.create(:opening_ticket, :user => user) }
          let(:url) { new_ticket_purchase_path(ticket) } 
          let(:image) { "/images/detail/buy_btn_01.gif" }
          let(:image_bottom) { "/images/detail/buy_btn02_01.gif" }

          it "購入するボタンがないこと" do
            visit ticket_path(ticket)
            within("li.dtl_buy_btn") do
              page.should have_xpath("img[@src='#{image}']")
            end

            within(".dtl_buy_btn_btm") do
              page.should have_xpath("img[@src='#{image_bottom}']")
            end
          end
        end

        context "自分のチケットではなく" do
          context "まだ購入していない場合" do
            let(:url) { new_ticket_purchase_path(ticket) } 
            let(:image) { "/images/detail/buy_btn.gif" } 
            let(:image_bottom) { "/images/detail/buy_btn02.gif" }

            it "購入するボタンがあること" do
              visit ticket_path(ticket)
              within("li.dtl_buy_btn") do
                page.should have_xpath("a[@href='#{url}']")
                page.should have_xpath("a//img[@src='#{image}']")
              end
              within(".dtl_buy_btn_btm") do
                page.should have_xpath("a[@href='#{url}']")
                page.should have_xpath("a//img[@src='#{image_bottom}']")
              end
            end
          end

          context "購入済みで" do
            before do
              FactoryGirl.create(:purchase, :user => user, :ticket => ticket)
            end

            let(:url) { new_ticket_review_path(ticket) } 
            let(:image) { "/images/detail/buy_btn_02.gif" } 
            let(:image_bottom) { "/images/detail/buy_btn02_02.gif" }

            context "レビューを書いていない場合" do
              it "レビューを書くボタンがあること" do
                visit ticket_path(ticket)
                # 上は購入するボタンか購入しないボタンだけになったのでテストはひとまずスルー
                # within("li.dtl_buy_btn") do
                #   page.should have_xpath("a[@href='#{url}']")
                #   page.should have_xpath("a//img[@src='#{image}']")
                # end

                within(".dtl_buy_btn_btm") do
                  page.should have_xpath("a[@href='#{url}']")
                  page.should have_xpath("a//img[@src='#{image_bottom}']")
                end
              end
            end

            context "レビューを書いている場合" do
              let(:image) { "/images/detail/buy_btn_01.gif" }
              let(:image_bottom) { "/images/detail/buy_btn02.gif" }

              before do
                FactoryGirl.create(:review, :user => user, :ticket => ticket)
              end

              it "購入するボタンがあること" do
                visit ticket_path(ticket)
                # 上は購入するボタンか購入しないボタンだけになったのでテストはひとまずスルー
                # within("li.dtl_buy_btn") do
                #   page.should have_xpath("img[@src='#{image}']")
                # end

                within(".dtl_buy_btn_btm") do
                  page.should have_xpath("a//img[@src='#{image_bottom}']")
                end
              end
            end
          end
        end
      end
    end

    context "販売終了していれば" do
      it "購入するボタンがないこと" do

      end
    end
  end

  describe "GET /all" do

    # ログインする
    include_context "capybara_login"

    it "出品中のチケットがあること" do
      FactoryGirl.create(:opening_ticket, :user => user)

      visit all_tickets_path
      find("p.myp_ckt_avr.txt11").should have_content("出品中")
    end

    it "下書きのチケットがあること" do
      FactoryGirl.create(:draft_ticket, :user => user)

      visit all_tickets_path
      find("p.myp_ckt_avr.txt11").should have_content("下書き")
    end

    it "審査中のチケットがあること" do
      FactoryGirl.create(:examining_ticket, :user => user)

      visit all_tickets_path
      find("p.myp_ckt_avr.txt11").should have_content("審査中")
    end

    it "編集待ちのチケットがあること" do
      FactoryGirl.create(:reject_ticket, :user => user)

      visit all_tickets_path
      find("p.myp_ckt_avr.txt11").should have_content("編集待ち")
    end

    it "出品終了のチケットがあること" do
      FactoryGirl.create(:closed_ticket, :user => user)

      visit all_tickets_path
      find("p.myp_ckt_avr.txt11").should have_content("出品終了")
    end

    it "出品中のチケットがないこと" do
      visit all_tickets_path
      page.should have_content("チケットがありません。")
    end
  end

  describe "GET /exhibits" do

    # ログインする
    include_context "capybara_login"

    context "出品中のチケットがある場合" do
      before do
        @ticket = FactoryGirl.create(:opening_ticket, :user => user)
        visit exhibits_tickets_path
      end

      it "チケットが表示されること" do
        within("p.myp_ttl_area") do
          page.should have_content(@ticket.title)
        end
      end

      it "チケットをイチオシにできること", :js => true do
        find("p.itiosi a.recommend").click
        within("p.itiosi") do
          page.should have_selector("a.active")
        end

        visit user_path(user.url_name)
        within("h3.txt20") do
          page.should have_content(@ticket.title)
        end
      end

      it "販売終了にできること", :js => true do
        find("p.myp_price_area a.mypbtn_he").click
        find("p.myp_ckt_avr.txt11").should have_content("出品終了")
        within("p.myp_ttl_area") do
          page.should have_content(@ticket.title)
        end

      end
    end


    it "出品中のチケットがないこと" do
      visit exhibits_tickets_path
      page.should have_content("チケットがありません。")
    end
  end

  describe "GET /drafts" do

    # ログインする
    include_context "capybara_login"

    it "下書きのチケットがあり、削除できること", :js => true do
      ticket = FactoryGirl.create(:draft_ticket, :user => user)

      visit drafts_tickets_path
      within("p.myp_ttl_area") do
        page.should have_content("hoge")
      end

      find("p.myp_price_area a.mypbtn_dr").click
      page.should have_content("チケットがありません。")
    end

    it "下書きのチケットがないこと" do
      visit drafts_tickets_path
      page.should have_content("チケットがありません。")
    end
  end

  describe "GET /examinings" do

    # ログインする
    include_context "capybara_login"


    it "審査中のチケットがあること" do
      FactoryGirl.create(:examining_ticket, :user => user)

      visit examinings_tickets_path
      within("p.myp_ttl_area") do
        page.should have_content("hoge")
      end
    end

    it "審査中のチケットがないこと" do
      visit examinings_tickets_path
      page.should have_content("チケットがありません。")
    end
  end

  describe "GET /rejections" do

    # ログインする
    include_context "capybara_login"

    it "不採用のチケットがあること" do
      ticket = FactoryGirl.create(:reject_ticket, :user => user)
      FactoryGirl.create(:rejection_ticket, :ticket => ticket)

      visit rejections_tickets_path
      within("p.myp_ttl_area") do
        page.should have_content("hoge")
      end
    end

    it "不採用のチケットがないこと" do
      visit rejections_tickets_path
      page.should have_content("チケットがありません。")
    end
  end

  describe "GET /closes" do

    # ログインする
    include_context "capybara_login"

    it "出品終了のチケットがあること" do
      FactoryGirl.create(:closed_ticket, :user => user)

      visit closes_tickets_path
      within("p.myp_ttl_area") do
        page.should have_content("hoge")
      end
    end

    it "出品終了のチケットがないこと" do
      visit closes_tickets_path
      page.should have_content("チケットがありません。")
    end
  end

  describe "GET /search(/:q)" do
    before do
      @ticket = FactoryGirl.create(:opening_ticket) 
      @purchased_ticket = FactoryGirl.create(:purchase) 
    end
    it "検索にヒットするチケットが存在すること", :js => true do
      visit root_path
      # 検索フォームに値を入力
      within("#search_form") do
        fill_in 'search_word', :with => @ticket.title
      end
      find_button('検索').click
      current_path.should == tickets_search_tickets_path(@ticket.title)

      within(".cntbox") do
        page.should have_content("\"#{@ticket.title}\"の検索結果")
      end
      within(".box_reg") do 
        page.should have_content(@ticket.title)  
      end
    end

    it "検索にヒットするチケットが存在しないこと", :js => true do
      query = "tigau"
      visit root_path
      # 検索フォームに値を入力
      within("#search_form") do
        fill_in 'search_word', :with => query
      end
      find_button('検索').click
      current_path.should == tickets_search_tickets_path(query)

      within(".search0") do 
        page.should have_content("#{query}に関するチケットをリクエストしてみましょう。")  
      end
      
      page.should have_content("最近購入されたチケット")
      within(".box_reg") do 
        page.should have_content(@purchased_ticket.ticket.title)
      end 
      find(".search0 img").click  
      current_path.should == request_messages_path
    end
  end
end
