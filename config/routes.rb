Rails.application.routes.draw do
  get 'notification/update'

  get 'services/search', :to => 'services#search', :as => 'search_services'
  resources :services


  #notificaitons
  patch 'notifications/:id', :to => 'notifications#update', :as => 'update_notification'

  # Transaction
  post 'transactions', :to => 'transaction#create', :as => 'transactions'
  get 'service/:id/petition', :to => 'transaction#new', :as => 'new_service_petition'
  get 'petition/:id/edit', :to => 'transaction#edit', :as => 'edit_service_petition'
  patch 'petition/:id', :to => 'transaction#update', :as => 'update_service_petition'
  post 'petition/:id/accept', :to => 'transaction#accept', :as => 'accept_service_petition'
  post 'petition/:id/cancel', :to => 'transaction#cancel', :as => 'cancel_service_petition'
  post 'petition/:id/done', :to => 'transaction#done', :as => 'done_service_petition'

  # Transaction Messages
  get 'transactions/:id/messages', :to => 'message#index', :as => 'transaction_messages'
  post 'transaction/:id/messages', :to => 'message#create', :as => 'create_transaction_message'

  #Account
  get 'profile/account', :to => 'account#index', :as => 'user_account'

  get 'categories/new', :to => 'category#new', :as => 'new_category'
  get 'categories', :to => 'category#index', :as => 'categories'
  post 'categories', :to => 'category#create'

  #user
  get 'user/notifications', :to => 'user#notifications', :as => 'user_notifications'
  get 'profile', :to => 'user#index', :as => 'user_index'
  get 'profile/services', :to => 'user#services', :as => 'user_services'
  get '/404' => 'home#index'


  get '/login', :to => 'home#index', :as => 'login'

  root :to => 'home#index'

  #registration
  post '/api/sign_up', :to => 'api/registration#create', :as => 'create_account'

  # session
  post '/api/session', :to => 'api/session#create', :as => 'create_session'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
