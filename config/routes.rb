# encoding: utf-8

RasVn::Application.routes.draw do
  get "users/registrated"

  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout

  root to:"top#index"
  devise_for :user
  get "top/index", as:'user_root'
  match '/recipes/recipe_foods/:recipe_food_id', controller:"recipes", action:"index"

  resource(:profile){ collection { get :delete_confirm } }
  resources(:bookmarks)
  resources(:diaries)
  resources(:facebook_friends) { collection { get :invited; post :invite } }
  resources(:information)
  resources(:kitchens) { member { get :recipes, :follow, :recipe_comments, :retired_chef } }
  resources(:recipes) { collection { get :love, :caution, :youtube, :publication } }
  resources(:recipe_comments)
  resources(:recipe_foods, only:[:index]){ collection{ post :index } }
  resources(:recipe_food_genres, only:[:index])
  resources(:streams)
  resources(:newsfeeds, only:[:index,:show])
  resources(:mypage, only:[:index]) do
    collection { get :recipes, :diary, :recipe_comments, :follow, :follower, :account_setting }
  end
  resources(:users, only: []){ collection{ get :stop_confirm, :stoped, :recover_confirm, :recovered; post :stop, :recover } }

  match '/cooporation(/:action(/:id))', controller:"cooporations"
  match '/statistics(/:action(/:id))', controller:"statistics"
end

