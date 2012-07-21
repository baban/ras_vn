# encoding: utf-8
require 'spec_helper'

describe "Boards" do
  describe "GET /users/:user_id/boards/:board_id" do
    # ログインする
    include_context "capybara_login"

    before do
      @user2 = FactoryGirl.create(:user)
      @note = FactoryGirl.create(:note, :user => @user2)
      @note_comment = FactoryGirl.build(:note_comment, :note => @note, :user => @user)
    end

    it "ボードの詳細画面の閲覧から、ボードのコメントまでできること", :js => true do
      visit user_note_path(@user2.url_name, @note)

      # ボードの詳細データが表示されていること
      page.should have_content(@user2.name) 
      page.should have_content(@note.body) 

      stub_request(:post, "https://graph.facebook.com/me/feed").
        with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> @note_comment.body}).
        to_return(:status => 200, :body => {})

      # コメントを記載
      fill_in "note_comment_body", :with => @note_comment.body 
      page.evaluate_script("document.forms[0].submit()")
      
      find("#note_comment_body").should have_no_content(@note_comment.body)
      find(".bd_cmtdtl_tt").should have_content(@note_comment.body) 
    end
  end

  describe "GET /users/:user_id" do
    # ログインする
    include_context "capybara_login"
    context "他人のボードを訪れた時" do
      before { @user2 = FactoryGirl.create(:user) }
      it "ボードが作成できること" do
        note = build(:note)
        stub_request(:post, "https://graph.facebook.com/me/feed").
          with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> note.body}).
          to_return(:status => 200, :body => {})

        visit user_path(@user2.url_name)
        fill_in "note_body", :with => note.body
        find(".my_bd_btn_b").click
        current_path.should == user_path(@user2.url_name)
      end
    end
  end

  describe "GET /users/:user_id/boards" do
    # ログインする
    include_context "capybara_login"

    context "自分のボードを訪れた時" do
      it "自分の作成したボードが削除できること", :js => true do
        note = FactoryGirl.create(:note, :user => user) 
        visit boards_user_path(user.url_name)
        find("#delete_board_#{note.id}").click
        find(".my_bd_bs").should have_no_content(note.body)
      end

      it "他人の作成したボードが削除できないこと", :js => true do
        user2 = create(:user)
        note = FactoryGirl.create(:note, :user => user2, :in_reply_to_user => user) 
        visit boards_user_path(user.url_name)
        page.body.should_not include("#delete_board_#{note.id}")
      end

      it "自分の作成したボードにコメントができること", :js => true do
        note = FactoryGirl.create(:note, :user => user) 
        visit boards_user_path(user.url_name)
        stub_request(:post, "https://graph.facebook.com/me/feed").
          with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> "hogehoge"}).
          to_return(:status => 200, :body => {})

        fill_in "note_comment_body", :with => "hogehoge"
        click_button "投稿する"

        find("#note_comment_body").should have_no_content("hogehoge")
        within ".bd_cmt_bg" do
          page.should have_content("hogehoge") 
        end
      end

      it "自分のボードコメントを削除できること", :js => true do
        note = FactoryGirl.create(:note, :user => user) 
        note_comment = FactoryGirl.create(:note_comment, :note => note, :user => user)
        visit boards_user_path(user.url_name)
        find("#delete_board_comment_#{note_comment.id}").click
        find(".bd_cmt_bg").should have_no_content(note_comment.body)
      end 
    end

    context "他人のボードを訪れた時" do
      before do
        @user2 = FactoryGirl.create(:user)
      end
      it "ボードが作成できること", :js => true do
        note = build(:note)
        stub_request(:post, "https://graph.facebook.com/me/feed").
          with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> note.body}).
          to_return(:status => 200, :body => {})

        visit boards_user_path(@user2.url_name)
        fill_in "note_body", :with => note.body
        page.evaluate_script("document.forms[0].submit()")
        current_path.should == boards_user_path(@user2.url_name)
        find(".my_bd_bs").should have_content(note.body)
      end

      it "自分の作成したボードが削除できること", :js => true do
        note = FactoryGirl.create(:note, :user => user, :in_reply_to_user => @user2)
        visit boards_user_path(@user2.url_name)
        find("#delete_board_#{note.id}").click
        find(".my_bd_bs").should have_no_content(note.body)
      end

      it "自分の作成したボードにコメントができること", :js => true do
        note = FactoryGirl.create(:note, :user => user, :in_reply_to_user => @user2)
        stub_request(:post, "https://graph.facebook.com/me/feed").
          with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> "hogehoge"}).
          to_return(:status => 200, :body => {})
        visit boards_user_path(@user2.url_name)
        page.should have_selector "div.bd_cmt_ct.dev_none"

        fill_in "note_comment_body", :with => "hogehoge"

        page.should have_no_selector "div.bd_cmt_ct.dev_none"
        click_button "投稿する"

        find("#note_comment_body").should have_no_content("hogehoge")
        within ".bd_cmt_bg" do
          page.should have_content("hogehoge") 
        end
      end

      it "他人の作成したボードにコメントができること", :js => true do
        note = FactoryGirl.create(:note, :user => @user2)
        stub_request(:post, "https://graph.facebook.com/me/feed").
          with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> "hogehoge"}).
          to_return(:status => 200, :body => {})
        visit boards_user_path(@user2.url_name)
        fill_in "note_comment_body", :with => "hogehoge"
        click_button "投稿する"

        find("#note_comment_body").should have_no_content("hogehoge")
        within ".bd_cmt_bg" do
          page.should have_content("hogehoge") 
        end
      end

      it "自分の作成したボードコメントを削除できること", :js => true do
        note = FactoryGirl.create(:note, :user => user, :in_reply_to_user => @user2)
        note_comment = FactoryGirl.create(:note_comment, :note => note, :user => user)
        visit boards_user_path(@user2.url_name)
        find("#delete_board_comment_#{note_comment.id}").click
        find(".bd_cmt_bg").should have_no_content(note_comment.body)
      end 
    end

    context "チケットを訪れた時" do
      before do
        @ticket = FactoryGirl.create(:opening_ticket)
        @user2 = FactoryGirl.create(:user)
      end
      it "コメントができること", :js => true do
        note = build(:note)
        visit ticket_path(@ticket)

        page.should have_selector "div.bd_cmt_ct.dev_none"

        fill_in "note_body", :with => note.body 

        stub_request(:post, "https://graph.facebook.com/me/feed").
          with(:body => {"access_token"=> /.+/, "link"=> /.+/, "message"=> /.+/, "name"=> note.body}).
          to_return(:status => 200, :body => {})

        page.should have_no_selector "div.bd_cmt_ct.dev_none"
        click_button "投稿する"

        find("#note_body").should have_no_content(note.body)
        within ".bd_cmt_bg" do
          page.should have_content(note.body) 
        end
      end

      it "自分の作成したコメントが削除できること", :js => true do
        note = FactoryGirl.create(:note, :user => user, :in_reply_to_user => @user2, :ticket => @ticket)
        visit ticket_path(@ticket)
        find(".bd_cmt_bg").should have_content(note.body)
        find(".delete_ticket_board").click
        find(".bd_cmt_bg").should have_no_content(note.body)
      end
      
      it "チケットをお気に入りできること", :js => true do
        ticket = FactoryGirl.create(:opening_ticket)
        visit ticket_path(ticket)
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
