# encoding: utf-8

RasVn::Application.routes.draw do
  get "mypage/index"

  get "bookmark/index"

  get "bookmark/create"

  get "bookmark/deatroy"

  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match '/admin/:controller(/:action(/:id))(.:format)'

  match ':controller(/:action(/:id))(.:format)'
end
