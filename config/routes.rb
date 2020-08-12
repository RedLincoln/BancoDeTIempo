Rails.application.routes.draw do
  get 'profile', :to => 'user#index', :as => 'user_index'
  root :to => 'home#index'
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
