# encoding: utf-8

RasVn::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout

  resource :profile

  resources(:bookmarks)
  resources(:diary)
  resources(:information)
  resources(:recipes){ collection { get :like, :caution } }
  resources(:recipe_advertisements)
  resources(:recipe_comments)
  resources(:recipe_foods)
  resources(:mypage){ member { get :recipes, :recipe_comments } }
  resources(:kitchens) { member { get :recipes } }

  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'

  scope :admin do
    match ':controller(/:action(/:id))(.:format)'
    match ':controller(/:action)'
  end
end
