# encoding: utf-8
require 'spec_helper'
require 'support/capybara_login_context'

describe "RequestMessage" do
  # ログインする
  include_context "capybara_login"

  describe "GET /request_messages" do
    before do
      @user2 = FactoryGirl.create(:user)
      FactoryGirl.create(:friendship, :user => user, :friend => @user2)
    end
    it "リクエスト新規登録から削除までできること" , :js => true do

      # ユーザーページに遷移
      visit user_path(@user2.url_name)

      # ユーザのプロフィールページからリクエストを行う
      within "div.pro_btn_area" do
        page.should have_content("リクエスト")
        click_link("リクエスト")
      end
      current_path.should == request_messages_path

      # データが０件の時
      page.should have_content("まだリクエストはありません。")
      within "div.similarity" do
        page.should have_content("まだリクエストに応えたチケットはありません。")
      end

      # リクエストの内容が空だとvalidateに引っかかる
      find("#user_submit").click
      page.should have_content("本文(300字以内)を入力してください")

      # 値を入力
      request_message = FactoryGirl.build(:request_message, :user => user)
      stub_request(:post, "https://graph.facebook.com/me/feed").
        with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> request_message.description}).
        to_return(:status => 200, :body => {})
      fill_in "request_message_description", :with => request_message.description

      # ユーザー選択を解除
      page.should have_no_content("出品してほしいユーザーがいる場合は選択してください。")
      within("div#reset_request_user") do
        click_link("×")
      end
      page.should have_content("出品してほしいユーザーがいる場合は選択してください。")

      # カラーボックスでのユーザー選択
      within("div#select_request_user") do
        click_link("ユーザー選択")
      end
      within("div#cboxLoadedContent") do
        page.should have_content(@user2.name)
        click_link("リクエストを送る")
      end
      page.should have_no_content("出品してほしいユーザーがいる場合は選択してください。")

      # ボタンを押すとデータが登録され、詳細画面へ遷移すること
      find("#user_submit").click
      within("h3.txt25") do
        page.should have_content(request_message.description)
      end

      # 一覧画面に戻り、削除ができる事を確認 
      visit request_messages_path
      page.should have_content(request_message.description)
      within("div.flo_l.clearfix.ct_area") do
        click_link("×")
      end
      page.should have_no_content(request_message.description)

    end

    it "データがある場合、リクエストのデータが閲覧できること"  , :js => true do
      request_message1 = FactoryGirl.create(:request_message, :user => @user2)
      ticket1 = FactoryGirl.create(:opening_ticket, :user => @user2, :request_message => request_message1)
      request_message2 = FactoryGirl.create(:request_message, :user => user, :to_user => @user2)
      ticket2 = FactoryGirl.create(:opening_ticket, :user => @user2, :request_message => request_message2)

      # リクエスト一覧ページに遷移
      visit request_messages_path

      # リクエスト一覧が見えること
      within "div.rqt_cont" do
        page.should have_content(request_message1.description)
        page.should have_content(request_message2.description)
      end

      # ほしいボタンが押せること
      page.should_not have_content("ほしくない")
      click_link("ほしい！")
      page.should have_content("ほしくない")

      # ほしいボタンの取り消しができること
      click_link("ほしくない")
      page.should_not have_content("ほしくない")

      # 登録済みリクエスト一覧がサイドに表示されること
      within "div.similarity" do
        page.should have_content("リクエストに応えたチケット")
        page.should have_content(ticket1.title)
      end
    end
  end

  describe "GET /request_messages/:id" do
    # ログインする
    include_context "capybara_login"
    
    before do
      user2 = FactoryGirl.create(:user)
      @request_message = FactoryGirl.create(:request_message, :user => user2)
      @ticket1 = FactoryGirl.create(:opening_ticket, :user => user, :request_message => @request_message)
      @ticket2 = FactoryGirl.create(:opening_ticket, :user => user2, :request_message => @request_message)
      FactoryGirl.create(:want, :user => user2, :request_message => @request_message)
      @request_message.reload
      @default_wants_count = @request_message.wants_count 
    end
    it "リクエストの詳細情報から、チケット出品まで", :js => true  do
      visit request_message_path(@request_message)

      # ほしい！&取り消しができる
      within "span.arigato_count" do
        page.should have_content("#{@default_wants_count}")
        page.should have_no_content("#{@default_wants_count}+1")
      end
      page.should have_content("ほしい！")
      page.should have_no_content("取り消し")
      click_link("ほしい！")
      within "span.arigato_count" do
        page.should have_no_content("#{@default_wants_count}")
        page.should have_content("#{@default_wants_count+1}")
      end
      page.should have_no_content("ほしい！")
      click_link("ほしくない")
      within "span.arigato_count" do
        page.should have_no_content("#{@default_wants_count+1}")
        page.should have_content("#{@default_wants_count}")
      end
      page.should have_no_content("ほしくない")
      
      # リクエストに応えたチケット一覧が表示されていること
      within "div.rqt_nst.cl.clearfix" do
        page.should have_content(@ticket1.title)
        page.should have_content(@ticket2.title)
      end

      # 「このチケットを出品する」をクリックして遷移。hiddenのパラメータにリクエストidがセットされていること
      click_link "このチケットを出品"
      current_path.should == new_ticket_path
      find("#ticket_request_message_id").value.should == "#{@request_message.id}"
    end
  end
end
