Rails.application.routes.draw do
  resources :services

  # Transaction
  post 'transactions', :to => 'transaction#create', :as => 'transactions'

  get 'categories/new', :to => 'category#new', :as => 'new_category'
  get 'categories', :to => 'category#index', :as => 'categories'
  post 'categories', :to => 'category#create'

  get 'profile', :to => 'user#index', :as => 'user_index'
  get 'profile/services', :to => 'user#services', :as => 'user_services'
  root :to => 'home#index'
  devise_for :users

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
