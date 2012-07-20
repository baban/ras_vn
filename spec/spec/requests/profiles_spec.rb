# encoding: utf-8
require 'spec_helper'

describe "Profiles" do
  describe "GET /users/:id" do
    # ログインする
    include_context "capybara_login"
    before do
      @user2 = FactoryGirl.create(:user)
      @ticket = FactoryGirl.create(:opening_ticket, :user => @user2)
    end

    it "チケットが存在すること" do
      visit user_path(@user2.url_name)
      page.should have_content(@ticket.title)
    end

    it "followできること", :js => true do
      visit user_path(@user2.url_name)
      find(".follow_btn .follow").click
      page.should have_selector(".follow2_btn")
    end

    it "unfollowできること", :js => true do
      FactoryGirl.create(:friendship, :user => user, :friend => @user2)
      visit user_path(@user2.url_name)
      find(".follow2_btn .unfollow").click
      page.should have_selector(".follow_btn")
    end
  end

  describe "GET /users/:id/boards" do
    # ログインする
    include_context "capybara_login"
    it "ボードの一覧が見れること" do
      visit boards_user_path(user.url_name)

      # ナビゲーションが"ボード"が選ばれていること
      find("ul.menu_list li.on").should have_content("ボード")

      # データがない場合
      page.should have_content("ボードがありません") 
       
      # データ作成して、もう一度ページに訪れる
      @note = FactoryGirl.create(:note, :user => user)
      visit boards_user_path(user.url_name)
      page.should_not have_content("ボードがありません") 
      page.should have_selector("ul.my_bd_bs")
    end
  end

  describe "POST /notes/:note_id/note_comments" do
    # ログインする
    include_context "capybara_login"

    before do
      @user = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => @user)
    end

    it "コメントができること", :js => true do
      stub_request(:post, "https://graph.facebook.com/me/feed").
        with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> "hogehoge"}).
        to_return(:status => 200, :body => {})

      visit boards_user_path(@user.url_name)
      fill_in "note_comment_body", :with => "hogehoge"
      page.evaluate_script("document.forms[1].submit()")

      find("#note_comment_body").should have_no_content("hogehoge")
      find(".bd_cmt_bg").should have_content("hogehoge") 
    end

    it "コメントが削除できること", :js => true do
      note_comment = FactoryGirl.create(:note_comment, :user => user, :note => @note)

      visit boards_user_path(@user.url_name)
      find("#delete_board_comment_#{note_comment.id}").click
      find(".bd_cmt_bg").should have_no_content(note_comment.body)
    end
  end

  describe "DELETE /notes/:note_id/note_comments/:id" do
    # ログインする
    include_context "capybara_login"
    before do
      @note = FactoryGirl.create(:note, :user => user)
      @note_comment = FactoryGirl.create(:note_comment, :note => @note, :user => user)
    end
    it "ボードのコメントを削除できること", :js => true do
      visit boards_user_path(user.url_name)
      page.should have_content(@note_comment.body) 

      # 削除リンクをクリック
      click_link "x"

      # データが削除されていること
      page.should_not have_content(@note_comment.body) 
    end
  end
end
