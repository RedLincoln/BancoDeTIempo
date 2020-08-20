Rails.application.routes.draw do
  resources :services
  get 'profile', :to => 'user#index', :as => 'user_index'
  get 'profile/services', :to => 'user#services', :as => 'user_services'
  root :to => 'home#index'
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
