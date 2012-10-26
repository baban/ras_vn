# encoding: utf-8

require 'spec_helper'

feature "作成" do
  flextures :users, :user_profiles, :user_profile_visibilities

  describe "GET 'index'" do
    context "ログイン時" do
      before do
        visit '/user/sign_in'
        fill_in "user_email", with:"babanba.n@gmail.com"
        fill_in "user_password", with:"svc2027"
        
        click_on "sign_in"
      end


      scenario "returns http success" do
        current_path.should == '/top/index'

        visit '/recipes/new'
        fill_in "recipe_title", with:"title"
        fill_in "recipe_description", with:"description"
        attach_file "recipe_recipe_image", File.join(Rails.root.to_path, "public/watermark.png")

        click_on "regist_button"
        current_path.should == '/recipes/edit'
      end
    end
  end
end
