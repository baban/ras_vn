# encoding: utf-8

RasVn::Application.routes.draw do
  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'
end
