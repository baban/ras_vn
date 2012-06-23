# encoding: utf-8

RasVn::Application.routes.draw do
  get "chefs/show"

  resource(:mypage){ member { get :index, :recipes, :recipe_comments } }
  resource :profile

  resources(:bookmarks)
  resources(:information)
  resources(:recipes){ member { get :like } }
  resources(:recipe_comments)
  resources(:restaurants)
  resources(:kitchens) { member { get :recipes } }

  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'

  scope :admin do
    match ':controller(/:action(/:id))(.:format)'
  end
end
