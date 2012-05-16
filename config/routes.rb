# encoding: utf-8

RasVn::Application.routes.draw do
  resource :profile
  resource :bookmark
  resource :information

  resources :recipes

  get "mypage/index"

  root to:"top#shop"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'

  scope :admin do
    match ':controller(/:action(/:id))(.:format)'
  end
end
