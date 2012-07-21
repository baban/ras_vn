# encoding: utf-8
require 'spec_helper'
require 'support/capybara_login_context'

describe "user search" do
  describe "GET /users/:id/recommends" do

    # ログインする
    include_context "capybara_login"

    it "おすすめユーザーの一覧が見えること"  do
      # ユーザーページに遷移
      visit recommends_user_path(user.url_name)

      # おすすめデータがない時
      page.should have_content("現在おすすめユーザーはいません。時間を置くと、新しいユーザーが表示される場合があります。")

      # おすすめデータがある時
      @user2 = FactoryGirl.create(:user)
      @recommend2 = FactoryGirl.create(:recommend_user, :user => @user2)
      visit recommends_user_path(user.url_name)

      page.should have_no_content("現在おすすめユーザーはいません。時間を置くと、新しいユーザーが表示される場合があります。")
      page.should have_content(@user2.name)
    end

  end

  describe "GET /search(/:q)" do

    # ログインする
    include_context "capybara_login"

    it "検索にヒットするユーザーが存在すること", :js => true do
      visit root_path
      find_link('ユーザー検索').click
      find_link('キーワード検索').click
      # 検索フォームに値を入力
      within("#search_form") do
        fill_in 'search_word', :with => user.name
      end
      find_button('検索').click
      current_path.should == users_search_users_path(user.name)

      within("h3.flo_l.pnone") do
        page.should have_content("\"#{user.name}\"の検索結果")
      end

      within("p.flo_l") do 
        page.should have_content("1件")  
      end
    end

    it "検索にヒットするユーザーが存在しないこと", :js => true do
      query = "tigau"
      visit root_path
      find_link('ユーザー検索').click
      find_link('キーワード検索').click
      # 検索フォームに値を入力
      within("#search_form") do
        fill_in 'search_word', :with => query
      end
      find_button('検索').click
      current_path.should == users_search_users_path(query)

      within("p.flo_l") do 
        page.should have_content("0件")  
      end
    end
  end
end
