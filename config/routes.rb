# encoding: utf-8

RasVn::Application.routes.draw do
  get "chefs/show"

  resource(:mypage){ member { get :index, :recipes } }
  resource :profile

  resources :bookmarks
  resources :information
  resources :recipes
  resources :recipe_comments
  resources :restaurants
  resources :chefs

  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'

  scope :admin do
    match ':controller(/:action(/:id))(.:format)'
  end
end
