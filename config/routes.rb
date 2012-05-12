# encoding: utf-8

RasVn::Application.routes.draw do
  get "recipe/index"

  get "recipe/show"

  get "recipe/edit"

  get "recipe/create"

  get "recipe/destroy"

  get "recipe/new"

  resource :profile

  get "mypage/index"

  get "bookmark/index"

  get "bookmark/create"

  get "bookmark/deatroy"

  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'

  scope :admin do
    match ':controller(/:action(/:id))(.:format)'
  end
end
