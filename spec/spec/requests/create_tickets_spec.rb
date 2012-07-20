# encoding: utf-8
require 'spec_helper'
require 'support/capybara_login_context'

describe "CreateTickets" do
  # ログインする
  include_context "capybara_login"

  describe "GET /exhibitors/new" do
    context "メール未認証の場合" do
      let(:user) { FactoryGirl.create(:unverified_email_user) }
      it "メール設定画面へとリダイレクトすること" do
        visit new_exhibitor_path
        current_path.should == edit_email_user_path(user.url_name)
        page.should have_content("商品の出品にはメール認証が必要です。")
      end
    end

    context "メール認証済みの場合" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        @exhibitor = FactoryGirl.build(:exhibitor, :user => user)
      end

      it "出品者登録で完了すること", :js => true do
        visit new_exhibitor_path

        # 値を入力する
        fill_in "exhibitor_name", :with => @exhibitor.name
        fill_in "exhibitor_zip_code", :with => @exhibitor.zip_code
        fill_in "exhibitor_address", :with => @exhibitor.address
        fill_in "exhibitor_tel", :with => @exhibitor.tel
        attach_file "exhibitor_license_image_file", Rails.root.to_s + "/spec/support/images/nikujaga.jpg"
        check "exhibitor_accept"
        find(".regi_btn").click

        # 完了画面へ
        current_path.should == complete_exhibitors_path
        page.should have_content("出品者の審査を受け付けました。")
      end
    end
  end

  describe "GET /tickets/new" do
    context "メール未認証の場合" do
      let(:user) { FactoryGirl.create(:unverified_email_user) }
      it "メール設定画面へとリダイレクトすること" do
        visit new_ticket_path
        current_path.should == edit_email_user_path(user.url_name)
        page.should have_content("商品の出品にはメール認証が必要です。")
      end
    end

    context "メール認証済みの場合" do
      before do
        @category = FactoryGirl.create(:category)
        @ticket_template = FactoryGirl.create(:ticket_template)
        @ticket = FactoryGirl.build(:ticket, :user => user, :category => @category)
        FactoryGirl.create(:attachment, :user => user, :ticket => @ticket)
      end

      it "チケットの出品審査まで完了すること", :js => true do
        visit new_ticket_path
        current_path.should == new_ticket_path

        within "ol.pkz" do
          page.should have_content("チケット登録")
        end

        # 値を入力する
        select @category.name, :from => "ticket_category_id"
        fill_in "ticket_title", :with => @ticket.title
        click_button "次へ"

        # 編集画面に遷移する
        find("#ticket_title").value.should == @ticket.title

        # タイトル入力
        find("#title_display_area").click
        page.should have_selector("#title_display_area.dev_none")
        fill_in "title_input_area", :with => "mogemoge"
        # カーソルを外す
        find("ol").click
        find("#title_display_area").should have_content("mogemoge")

        # 価格入力
        find("#price_display_area").click
        page.should have_selector("#price_display_area.dev_none")
        fill_in "price_input_area", :with => 1000
        # カーソルを外す
        find("ol").click
        find("#price_display_area").should have_content("1,000 円")

        # 在庫入力
        find("#stock_display_area").click
        page.should have_selector("#stock_display_area.dev_none")
        fill_in "stock_input_area", :with => 10 
        # カーソルを外す
        find("ol").click
        find("#stock_display_area").should have_content("10")

        # 納期入力
        find("#delivery_period_display_area").click
        page.should have_selector("#delivery_period_display_area.dev_none")
        fill_in "delivery_period_input_area", :with => 3 
        # カーソルを外す
        find("ol").click
        find("#delivery_period_display_area").should have_content("3")

        # メイン画像選択
        attach_file "ticket_image", Rails.root.to_s + "/spec/support/images/nikujaga.jpg"
        within ".edit_ticket" do
          page.should have_no_xpath("//img[@src=\"/images/registration/img_gr.gif\"]") 
        end
        
        # 本文入力
        find("#description_display_area").click
        page.should have_selector("#description_display_area.dev_none")
        # チケットテンプレートの選択(これで ticket_description が上書きされる)
        select @ticket_template.title, :from => "ticket_template"
        find_field("ticket_description_area").value.should == @ticket_template.body

        within "#description_input_area" do
          fill_in "text", :with => "# hoge \n moge"
        end

        # 添付画像のアップロード用のcolorboxを開く
        find("#open_attachment_box").click
        # TODO アップロードのテストがうまく動かない
        #page.should have_content("画像をアップロードします。")
        #page.should have_content("まだアップロードされた画像はありません。")

        # 画像をアップロード
        #within ".img_uplode" do
        #  attach_file "attachment_image", Rails.root.to_s + "/spec/support/images/nikujaga2.jpg"
        #end
        page.should have_no_content("まだアップロードされた画像はありません。")

        # アップロードされた画像の添付ボタンをクリック。ticket_description に画像のマークダウンが追加されること
        find(".upl_btn").click
        find_field("ticket_description_area").value.should have_content("![画像](/spec/support/uploads/attachment/image") 

        # カーソルを外す
        find(".fm_btn03").click
        within "#description_display_area" do
          page.should have_content("hoge moge")
        end

        attach_file "ticket_background_image", Rails.root.to_s + "/spec/support/images/nikujaga.jpg"
        find(".cl_bg_rep").should have_no_selector(".flo_r.btn_indent.dev_none")

        # 確認ボタンを押して確認画面へと遷移
        click_button "審査に出す"

        # 受付完了画面
        page.should have_content("チケット審査を受け付けました") 
      end
    end
  end
end
