# config/routes.rb
Rails.application.routes.draw do
  resources :cafes, only: [:show] do
    namespace :admin do
      devise_for :users, controllers: { sessions: 'admin/users/sessions' }
      resources :categories
      resources :menu_items
      get '/', to: 'dashboard#index', as: 'dashboard'
    end
  end

  root 'application#index'
end
