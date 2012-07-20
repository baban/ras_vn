# encoding: utf-8
require 'spec_helper'

describe "Homes" do
  describe "GET /bills" do
    # ログインする
    include_context "capybara_login"
    include ActionView::Helpers::NumberHelper

    before do
      @user1 = user
      @user2 = FactoryGirl.create(:exhibited_user)
      @user1_ticket1 = FactoryGirl.create(:opening_ticket, :user => @user1, :created_at => 2.month.ago, :price => 5000)
      @user1_ticket2 = FactoryGirl.create(:opening_ticket, :user => @user1, :created_at => 2.month.ago, :price => 4000)
      @user2_ticket1 = FactoryGirl.create(:opening_ticket, :user => @user2, :created_at => 2.month.ago, :price => 3000)
      @user2_ticket2 = FactoryGirl.create(:opening_ticket, :user => @user2, :created_at => 2.month.ago, :price => 2000)

      FactoryGirl.create(:purchase, :user => @user2, :ticket => @user1_ticket1, :cost => @user1_ticket1.price, :created_at => 1.month.ago)
      @user1_income1 = FactoryGirl.create(:income_bill, :user => @user1, :created_at => 1.month.ago, :cost => @user1_ticket1.price, :year => 1.month.ago.year, :month => 1.month.ago.month)

      FactoryGirl.create(:purchase, :user => @user1, :ticket => @user2_ticket1, :cost => @user2_ticket1.price, :created_at => 1.month.ago)
      @user1_payment1 = FactoryGirl.create(:payment_bill, :user => @user1, :created_at => 1.month.ago, :cost => @user2_ticket1.price, :year => 1.month.ago.year, :month => 1.month.ago.month)

      FactoryGirl.create(:purchase, :user => @user2, :ticket => @user1_ticket2, :cost => @user1_ticket2.price, :created_at => Time.now)
      @user1_income2 = FactoryGirl.create(:income_bill, :user => @user1, :created_at => Time.now, :cost => @user1_ticket2.price, :year => Time.now.year, :month => Time.now.month)

      FactoryGirl.create(:purchase, :user => @user1, :ticket => @user2_ticket2, :cost => @user2_ticket2.price, :created_at => Time.now)
      @user1_payment2 = FactoryGirl.create(:payment_bill, :user => @user1, :created_at => Time.now, :cost => @user2_ticket2.price, :year => Time.now.year, :month => Time.now.month)

    end
      
    it "利用明細が表示されること", :js => true do
      # 明細ページアクセス時（先月分の明細が表示）
      visit bills_path 
      # 手取りと支払額が表示されていることを確認
      find("#total_income").should have_content(number_with_delimiter(@user1_income2.cost * 60 / 100))
      find("#total_payment").should have_content(number_with_delimiter(@user1_payment2.cost))
      # 年月指定でページが切り替わること
      select(@user1_income1.created_at.to_s(:period), :from => "period")
      current_path.should == period_bills_path(:year => @user1_payment1.created_at.year, :month => @user1_payment1.created_at.strftime("%m"))

      # 手取りと支払額が表示されていることを確認
      find("#total_income").should have_content(number_with_delimiter(@user1_income1.cost * 60 / 100))
      find("#total_payment").should have_content(number_with_delimiter(@user1_payment1.cost))
    end
  end

  describe "GET /home" do

    # ログインする
    include_context "capybara_login"

    #before do
    #  @user2 = FactoryGirl.create(:user)
    #  FactoryGirl.create(:friendship, :user => user, :friend => @user2)
    #  ticket = FactoryGirl.create(:opening_ticket, :user => user)
    #  FactoryGirl.create(:review, :ticket => ticket, :user => user)
    #  FactoryGirl.create(:purchase, :ticket => ticket, :user => @user2)
    #  @note = FactoryGirl.create(:note, :user => @user2)
    #  @note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => user)
    #end

    it "ナビゲーションがアクティビティが選ばれていること" do
      visit home_path
      find("ul.menu_list li.on").should have_content("アクティビティ")
    end

    it "アクティビティがない場合、お勧めユーザーが表示されること" do
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:friendship, :user => @user2, :friend => user)
      
      visit home_path
      page.should have_content("お勧めユーザー")
      find(".prf_flw_ct").should have_content(@user2.name)
    end

    it "アクティビティが表示されていること" do
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:friendship, :user => user, :friend => @user2)
      ticket = FactoryGirl.create(:opening_ticket, :user => user)
      FactoryGirl.create(:review, :ticket => ticket, :user => user)
      FactoryGirl.create(:purchase, :ticket => ticket, :user => @user2)
      @note = FactoryGirl.create(:note, :user => @user2)
      @note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => user)

      visit home_path
      within(".prf_btm_main") do
        page.should have_content("フォローしました") 
        page.should have_content("購入されました") 
        page.should have_content("出品しました") 
        page.should have_content("レビューが投稿されました") 
        page.should have_content(@note.body) 
        page.should have_content(@note_comment.body) 
      end
    end
  end

  describe "GET /conversations" do
    # ログインする
    include_context "capybara_login"

    context "メッセージを送る相手がいない場合" do
      it "メッセージが無いこと" do
        visit conversations_path 
        page.should have_content("メッセージはありません")
      end
    end

    context "メッセージを送る相手がいる場合" do
      before do
        @purchase = FactoryGirl.create(:purchase, :user => user)
        conversation = FactoryGirl.create(:conversation, :purchase => @purchase)
        @user2 = @purchase.ticket.user
        FactoryGirl.create(:conversation_member, :conversation => conversation, :user => user) 
        FactoryGirl.create(:conversation_member, :conversation => conversation, :user => @user2) 
        @message = FactoryGirl.create(:message, :conversation => conversation, :user => user, :to_user => @user2) 
      end

      it "メッセージ一覧が表示されること" do
        visit conversations_path

        # ナビゲーションがメッセージが選ばれていること
        find("ul.menu_list li.on").should have_content("メッセージ")

        # メッセージが表示されていること
        within(".myp_msg") do
          page.should have_content(@message.body) 
        end

        # メッセージ送信可能者一覧が表示される
        find(".myp_msg").should have_content(@user2.name)
        find(".myp_msg li a").click

        within(".myp_ttl") do
          page.should have_content("#{@purchase.ticket.title} について")
          page.should have_content("#{@user2.name} さんとのメッセージ") 
        end
      end
    end
  end

  describe "GET /conversations/:id" do
    # ログインする
    include_context "capybara_login"

    before do
      user2 = FactoryGirl.create(:user)
      @conversation = FactoryGirl.create(:conversation)
      FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => user2) 
      @message1 = FactoryGirl.create(:message, :conversation => @conversation, :user => user, :to_user => user2) 
      @message2 = FactoryGirl.create(:message, :conversation => @conversation, :user => user, :to_user => user2) 
    end

    it "メッセージ詳細画面が正しく表示されていること" do
      visit conversation_path(@conversation)

      # ナビゲーションがメッセージが選ばれていること
      find("ul.menu_list li.on").should have_content("メッセージ")

      # 各種情報が正しく表示されていること 
      within(".myp_ttl") do
        page.should have_content("さんとのメッセージ") 
      end
      within(".myp_msg") do
        page.should have_content(@message1.body) 
        page.should have_content(@message2.body) 
      end
    end
  end

  describe "POST /conversations/:id/messages" do
    # ログインする
    include_context "capybara_login"

    before do
      user2 = FactoryGirl.create(:user)
      @conversation = FactoryGirl.create(:conversation)
      FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => user2)
      @message = FactoryGirl.create(:message, :conversation => @conversation, :user => user, :to_user => user2) 
    end

    it "メッセージ登録まで完了すること" do
      # 投稿画面へ
      visit conversation_path(@conversation)
      within(".myp_msg") do
        page.should have_content(@message.body) 
        page.should_not have_content("新しいメッセージ本文") 
      end

      # 値を入力する
      fill_in "message_body", :with => "新しいメッセージ本文"
      attach_file "message_file", Rails.root.to_s + "/spec/support/images/nikujaga.jpg"

      # 送信ボタンを押して、メッセージ詳細画面(現在いるページと同じページ)に遷移すること
      find(".my_bd_btn").click
      current_path.should == conversation_path(@conversation)

      # 登録したメッセージが表示されていること
      within(".myp_msg") do
        page.should have_content(@message.body) 
        page.should have_content("新しいメッセージ本文") 
      end
    end
  end

  describe "DELETE /conversations/:id/messages/:id" do
    # ログインする
    include_context "capybara_login"

    before do
      @user2 = FactoryGirl.create(:user)
      @conversation = FactoryGirl.create(:conversation)
      FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => user) 
      FactoryGirl.create(:conversation_member, :conversation => @conversation, :user => @user2)
      @message = FactoryGirl.create(:message, :conversation => @conversation, :user => user, :to_user => @user2) 
    end

    it "メッセージ削除まで完了すること" do
      # 投稿画面へ
      visit conversation_path(@conversation)
      find("title").should have_content("#{@user2.name}からのメッセージ")
      page.should have_content(@message.body) 

      # 削除リンクをクリックして、メッセージ詳細画面(現在いるページと同じページ)に遷移すること
      click_link "x"
      current_path.should == conversation_path(@conversation)

      # 登録したメッセージが削除されていること
      page.should_not have_content(@message.body) 
    end
  end
  
  describe "ボード投稿" do
    # ログインする
    include_context "capybara_login"

    it "ボード投稿ができること" do
      stub_request(:post, "https://graph.facebook.com/me/feed").
        with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=>"近況報告"}).
        to_return(:status => 200, :body => {})

      visit home_path
      fill_in "note_body", :with => "近況報告"
      find(".my_bd_btn").click 
      find(".my_bd_bs").should have_content("近況報告")
    end

    it "ボードが削除できること", :js => true do
      note = FactoryGirl.create(:note, :user => user) 
      visit home_path
      find("#delete_board_#{note.id}").click
      find(".my_bd_bs").should have_no_content(note.body)
    end

    it "自分のボードにコメントができること", :js => true do
      stub_request(:post, "https://graph.facebook.com/me/feed").
        with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=>"hogehoge"}).
        to_return(:status => 200, :body => {})

      note = FactoryGirl.create(:note, :user => user) 
      visit home_path

      fill_in "note_comment_body", :with => "hogehoge"
      page.evaluate_script("document.forms[1].submit()")

      find("#note_comment_body").should have_no_content("hogehoge")
      find(".bd_cmt_bg").should have_content("hogehoge") 
    end

    it "自分のボードコメントを削除できること", :js => true do
      note = FactoryGirl.create(:note, :user => user)  
      note_comment = FactoryGirl.create(:note_comment, :note => note, :user => user)
      visit home_path
      find("#delete_board_comment_#{note_comment.id}").click
      find(".bd_cmt_bg").should have_no_content(note_comment.body)
    end

    it "友人のボードにコメントができること", :js => true do
      stub_request(:post, "https://graph.facebook.com/me/feed").
        with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=>"hogehoge"}).
        to_return(:status => 200, :body => {})

      friend = FactoryGirl.create(:user)
      FactoryGirl.create(:friendship, :user => user, :friend => friend)
      note = FactoryGirl.create(:note, :user => friend)

      visit home_path
      fill_in "note_comment_body", :with => "hogehoge"
      page.evaluate_script("document.forms[1].submit()")

      find("#note_comment_body").should have_no_content("hogehoge")
      find(".bd_cmt_bg").should have_content("hogehoge") 
    end
  end

  describe "GET /notifications" do
    # ログインする
    include_context "capybara_login"

    it "お知らせが見れること" do
      visit notifications_path

      # ナビゲーションがお知らせが選ばれていること
      find("ul.menu_list li.on").should have_content("お知らせ")

    end
  end

  describe "GET /reports" do
    # ログインする
    include_context "capybara_login"

    it "レポートが見れること" do
      visit reports_path

      # ナビゲーションがレポートが選ばれていること
      find("ul.menu_list li.on").should have_content("レポート")
    end
  end
end
