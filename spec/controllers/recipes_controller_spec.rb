# encoding: utf-8

require 'spec_helper'

describe RecipesController do
  fixtures :users, :user_profiles, :user_profile_visibilities, :recipes, :recipe_comments

  context "非ログイン時" do
    describe "GET 'index'" do
      before do
        get :index
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'show'" do
      before do
        get :show, id: 2
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'new'" do
      before do
        get :new
      end
      it "returns http success" do
        response.should be_redirect
      end
    end

    describe "GET 'edit'" do
      before do
        get :edit, id: 2
      end
      it "returns http success" do
        response.should be_redirect
      end
    end
  end

  context "ログイン時" do
    include Devise::TestHelpers

    let(:prms) do
      {
        id: 11,
        step_number: 1,
        recipe_genre_selecter: 1,
        new_food_genre: "",
        recipe_draft:{
          title: "♥アスパラとじゃがいものチーズサラダ♥",
          description: "コロコロのアスパラとじゃがいもがとっても食べ易く、見た目も可愛いサラダです♡ ",
          recipe_food_id: 1,
          amount: 0,
          one_point: "③では塩を1つまみくらいいれました。アンチョビの塩分によって変わるので、調整をしてください。 ",
          public: true,
        }, 
        foodstuffs: [
           {"name"=>"アスパラ", "amount"=>"３本"},
           {"name"=>"じゃがいも", "amount"=>"中２個(約250ｇ)"},
           {"name"=>"プロセスチーズ", "amount"=>"２個(約30ｇ)"},
           {"name"=>"ハム", "amount"=>"２枚"},
           {"name"=>"マヨネーズ", "amount"=>"大さじ１～２"},
           {"name"=>"酢", "amount"=>"大さじ１/２"},
           {"name"=>"コショー", "amount"=>"少々"}
        ],
        recipe_steps: [
          {"movie_url"=>"", "content"=>""},
          {"movie_url"=>"", "content"=>""},
          {"movie_url"=>"", "content"=>""},
          {"movie_url"=>"", "content"=>""}
        ],
        "save"=>"Đăng xong recipe"
      }
    end

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.first
      sign_in @user
      p session
    end
    describe "GET 'index'" do
      before do
        get :index, recipe_food_id: 1
      end
      it "returns http success" do
        response.should be_success
      end
    end
=begin
    describe "GET 'show'" do
      before do
        get :show, id: 2
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'new'" do
      before do
        get :new
      end
      it "returns http success" do
        response.should be_success
      end
    end
=end
  end
end
