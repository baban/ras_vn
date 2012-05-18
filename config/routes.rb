# encoding: utf-8

RasVn::Application.routes.draw do
  get "recipe_steps/update"

  resource :profile
  resource :bookmark
  resource :information

  resources :recipes
  resources :restaurants

  get "mypage/index"

  root to:"top#index"

  devise_for :user
  get "top/index", as:'user_root'

  match ':controller(/:action(/:id))(.:format)'

  scope :admin do
    match ':controller(/:action(/:id))(.:format)'
  end
end
