# config/routes.rb
Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :cafes, only: [:show] do
    resources :categories, only: [:index, :show]
    resources :menu_items, only: [:index, :show]
    namespace :admin do
      resources :categories
      resources :menu_items
      get '/', to: 'dashboard#index', as: 'dashboard'
    end
  end

  root 'application#index'
end
