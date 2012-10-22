# encoding: utf-8

RasVn::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout

  root to:"top#index"
  devise_for :user
  get "top/index", as:'user_root'

  match '/recipes/recipe_foods/:recipe_food_id', controller:"recipes", action:"index"

  resource(:profile)
  resources(:bookmarks, :diary, :information)
  resources(:recipes) { collection { get :like, :caution } }
  resources(:recipe_advertisements, :recipe_comments, :recipe_foods)
  resources(:recipe_food_genres, only:[:index])
  resources(:streams)
  resources(:newsfeeds, only:[:index,:show])
  resources(:mypage, only:[:index]){ collection { get :recipes, :recipe_comments } }
  resources(:kitchens) { member { get :recipes } }

  match '/statistics(/:action(/:id))', controller:"statistics"
end

