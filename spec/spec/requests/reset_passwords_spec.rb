# encoding: utf-8
require 'spec_helper'

describe "ResetPasswords" do
  describe "GET /forgot_password" do
    include_context "capybara_login"

    it "パスワード再設定URL送信が完了すること", :js => true do
      edit_email_user_url(user.url_name)
      visit edit_email_user_path(user.url_name)

      # ナビゲーションがメールアドレス編集が選ばれていること 
      find("ul.range li.active").should have_content("メールアドレス")
      # 値を入力
      fill_in "user_email", :with => user.email
      find("input.radi10.txt16").click 
      # colorboxによるパスワード確認画面が出る
      page.should have_content("パスワード確認")
      click_button "パスワードを再設定する"
      page.should have_content("パスワード再設定用のメールを送信しました")
    end

    it "パスワードを再設定できること" do
      visit user.create_reset_password_url 
      page.should have_content("パスワード再設定")
      fill_in "user_password", :with => "hogehoge"
      fill_in "user_password_confirmation", :with => "hoge"
      click_button "パスワードを再設定する"
      page.should have_content("パスワードが一致しません")

      fill_in "user_password", :with => "hogehoge"
      fill_in "user_password_confirmation", :with => "hogehoge"
      click_button "パスワードを再設定する"
      page.should have_content("パスワード再設定が完了しました。")
    end
  end
end
