# encoding: utf-8
require 'spec_helper'

describe "User_setting" do
  describe "パスワード変更" do
    # ログインする
    include_context "capybara_login"

    it "パスワードが変更できること" do
      visit edit_password_user_path(user.url_name)
      # ナビゲーションがパスワード編集が選ばれていること 
      find("ul.range li.active").should have_content("パスワード")
      # 現在のパスワードを間違える
      fill_in "user_current_password", :with => "matigaeta-"
      find("input.radi10.txt16").click
      page.should have_content("現在のパスワードは不正な値です")

      fill_in "user_current_password", :with => user.password
      fill_in "user_password", :with => "2"
      fill_in "user_password_confirmation", :with => "2"
      find("input.radi10.txt16").click
      page.should have_content("パスワードは4文字以上で")

      fill_in "user_current_password", :with => user.password
      fill_in "user_password", :with => "kaeta"
      fill_in "user_password_confirmation", :with => "kaetta2"
      find("input.radi10.txt16").click
      page.should have_content("パスワードが一致しません。")

      fill_in "user_current_password", :with => user.password
      fill_in "user_password", :with => "kaeta"
      fill_in "user_password_confirmation", :with => "kaeta"
      find("input.radi10.txt16").click
      page.should_not have_selector("p.err")
    end
  end

  describe "GET /users/:id/edit_email" do
    # ログインする
    include_context "capybara_login"

    it "メールアドレスが変更できること", :js => true do
      visit edit_email_user_path(user.url_name)

      # ナビゲーションがメールアドレス編集が選ばれていること 
      find("ul.range li.active").should have_content("メールアドレス")
      # 値を入力
      fill_in "user_email", :with => user.email
      find("input.radi10.txt16").click 
      # colorboxによるパスワード確認画面が出る
      page.should have_content("パスワード確認")
      fill_in "user_current_password", :with => user.password
      click_button "確認する"
      page.should have_content("登録完了しました。確認用のメールを送信しましたのでご確認お願いします。")
    end 
  end

  describe "GET /users/:id/edit" do
    # ログインする
    include_context "capybara_login"

    it "プロフィール編集ができること" do
      visit edit_user_path(user.url_name)

      # ナビゲーションがプロフィール編集が選ばれていること 
      find("ul.range li.active").should have_content("プロフィール")

      # 値を入力して、画面遷移
      attach_file "user_image", Rails.root.to_s + "/spec/support/images/nikujaga.jpg"
      fill_in "user_name", :with => "変更後の名前。文字長が長過ぎる場合の例。hogehogehogehoge" * 3
      fill_in "user_description", :with => "変更後の自己紹介。" 
      check('user_subscribe_flag')
      find("input.radi10.txt16").click

      # 名前の文字数が長すぎるので、入力画面に戻る。正しい値を入力して画面遷移
      page.should have_content("名前は50文字以内で入力してください。") 
      fill_in "user_name", :with => "変更後の名前。" 
      check('user_subscribe_flag')
      find("input.radi10.txt16").click

      # 登録後はプロフィール編集画面にリダイレクトし、完了文言が表示されること
      current_path.should == edit_user_path(user.url_name)
      page.should have_content("プロフィール編集が完了しました。") 
    end
  end

  describe "GET /exhibitors/:id/edit" do
    # ログインする
    include_context "capybara_login"
    before do
      @exhibitor = FactoryGirl.create(:unregistered_bank_exhibitor, :user => user)
    end

    it "振込先の編集ができること" do
      visit edit_exhibitor_path(@exhibitor)

      # ナビゲーションが振込先が選ばれていること 
      find("ul.range li.active").should have_content("振込先")

      # 口座情報が空で販売履歴もないので下記文言は表示されない。
      page.should_not have_content("あなたが出品したチケットが購入されました。") 

      # 口座情報が空で販売履歴があるので、「チケット購入されました」文言が表示される
      income = FactoryGirl.create(:income_bill, :user => user)
      visit edit_exhibitor_path(@exhibitor)
      page.should have_content("あなたが出品したチケットが購入されました。") 

      # 値を入力して、画面遷移
      fill_in "exhibitor_bank_name", :with => "" 
      fill_in "exhibitor_bank_branch_name", :with => "銀行の支店名" 
      select(  "普通預金", :from => "exhibitor_bank_account_type")
      fill_in "exhibitor_bank_account_number", :with => "123456" 
      fill_in "exhibitor_bank_account_kana", :with => "コウザメイギ" 
      find("input.radi10.txt16").click

      # お振込先銀行名が空なので、入力画面に戻る
      find("ul.range li.active").should have_content("振込先")
      page.should have_content("お振り込み先金融機関口座を登録してください") 
      page.should have_content("あなたが出品したチケットが購入されました。") 
      current_path.should == exhibitor_path(@exhibitor)

      # 再び値を入力
      fill_in "exhibitor_bank_name", :with => "銀行名ほげほげ"
      find("input.radi10.txt16").click

      # データ登録後は振込先編集画面へと遷移し、完了文言が表示されること
      current_path.should == edit_exhibitor_path(@exhibitor)
      page.should have_content("振込先情報の編集が完了しました。") 
    end
  end

end
