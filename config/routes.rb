Rails.application.routes.draw do
  devise_for :users

  resources :category, only: [:index, :show]
  resources :menus, only: [:index, :show]

  namespace :admin do
    get '/', to: 'dashboard#index', as: 'dashboard'
    resources :categories
    resources :menus
  end

  root 'application#index'
end
