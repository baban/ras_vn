# encoding: utf-8

RasVn::Application.routes.draw do
  devise_for :users

  get "shop/show"
  get "shop/meny"
  get "shop/map"
  get "shop/reserve"
  get "top/index", as:'user_root'
  
  devise_for :user

  root to:"home#index"

  match ':controller(/:action(/:id))(.:format)'
end
