# encoding: utf-8

require 'spec_helper'

feature "作成" do
  flextures :users, :user_profiles, :user_profile_visibilities
  flextures :recipe_food_genres, :recipe_foods, :recipes, :recipe_drafts

  describe "GET 'index'" do
    context "ログイン時" do
      before do
        visit '/user/sign_in'
        fill_in "user_email", with:"babanba.n@gmail.com"
        fill_in "user_password", with:"svc2027"
        click_on "sign_in"
      end


      scenario "レシピ新規投稿" do
        current_path.should == '/top/index'

        # 作成ページ
        visit '/recipes/new'
        fill_in "recipe_title", with:"title"
        fill_in "recipe_description", with:"description"
        attach_file "recipe_recipe_image", File.join(Rails.root.to_path, "public/watermark.png")
        select "au /Củ /Quả", from:"recipe_genre_selecter"
        select "Thịt Bò", from: "recipe_recipe_food_id"
        select "Công khai", from:"recipe_public"
        click_on "regist_button"

        # 編集ページ
        page.should have_content('Nguyên liệu')
        fill_in "recipe_draft_title", with:"title"
        fill_in "recipe_draft_description", with:"description"
        fill_in "recipe_draft_one_point", with:"One point"
        fill_in "recipe_steps_1_content", with:"step1"
        click_on "save_button"

        `git clean -df -- public/uploads`
      end
    end
  end
end
