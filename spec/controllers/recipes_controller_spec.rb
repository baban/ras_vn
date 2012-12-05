# encoding: utf-8

require 'spec_helper'

describe RecipesController do
  fixtures :users, :user_profiles, :user_profile_visibilities
  fixtures :recipes, :recipe_comments, :recipe_drafts, :recipe_food_genres, :recipe_foods, :recipe_foodstuff_drafts, :recipe_foodstuffs, :recipe_step_drafts, :recipe_steps

  context "非ログイン時" do
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
      it "returns http redirect" do
        response.should be_redirect
      end
    end
  end

  context "ログイン時" do
    include Devise::TestHelpers

    let(:prms) do
      h = {
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
      }
      ActiveSupport::HashWithIndifferentAccess.new(h)
    end
    describe "GET 'new'" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @user = User.first
        @user.confirm!
        sign_in @user
      end
      before do
        get :new
      end
      it "returns http success" do
        response.should be_success
      end
    end

    describe "GET 'edit'" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @user = User.first
        @user.confirm!
        sign_in @user
      end

      context "my recipe" do
        before do
          get :edit, id: 11
        end
        it "returns http success" do
          response.should be_success
        end
      end

      context "other user's recipe " do
        before do
          get :edit, id: 1
        end
        it "returns http redirect" do
          response.should be_redirect
        end
      end
    end

    describe "GET publication" do
      context do
        before do
          @request.env["devise.mapping"] = Devise.mappings[:admin]
          @user = User.first
          @user.confirm!
          sign_in @user
        end

        before do
          get :publication, id: 15
        end
        it "returns http redirect" do
          response.should be_redirect
        end
        it "returns redirect to show action" do
          response.should redirect_to( action:"show", id: 15 )
        end
        it "returns http redirect" do
          Recipe.find(15).public.should be_true
        end
      end
    end
  end
end
