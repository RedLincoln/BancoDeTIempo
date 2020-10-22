Rails.application.routes.draw do
  get 'notification/update'

  get 'services/search', :to => 'services#search', :as => 'search_services'

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

  get '/service/edit/:id', :to => 'home#index'
  get '/demand', :to => 'home#index'
  get '/demand/new', :to => 'home#index'
  get '/petitions', :to => 'home#index'
  get '/services/petition/new', :to => 'home#index'
  get '/users', :to => 'home#index'
  get '/profile/:id', :to => 'home#index'
  get '/services', :to => 'home#index'
  get '/services/new', :to => 'home#index'
  get '/services/:id', :to => 'home#index'
  get '/admin/users', :to => 'home#index'
  get '/sign_up', :to => 'home#index', :as => 'sign_up'
  get '/login', :to => 'home#index', :as => 'login'

  root :to => 'home#index'




  #chat_room
  get '/api/chat_rooms', :to => 'api/chat_room#index'
  get '/api/chat_rooms/:id', :to => 'api/chat_room#show'
  post '/api/chat_rooms/message/:id', :to => 'api/chat_room#create_message'
  get '/api/chat_rooms/message/:id', :to => 'api/chat_room#get_messages'
  post '/api/chat_room/:id/reset_read_count', :to => 'api/chat_room#reset_count'

  #categories
  get '/api/categories', :to => 'api/categories#index'

  #tags
  get '/api/tags', :to => 'api/tags#index'

  #user
  get '/api/users/:id', :to => 'api/user#show'
  get '/api/notifications',  :to => 'api/user#notifications'
  get '/api/notification/seen/:id', :to => 'api/user#seen_notification'

  #service petitions
  post '/api/services/petition', :to => 'api/transaction#create'
  get '/api/services/petition', :to => 'api/transaction#index'

  #services
  get '/api/services', :to => 'api/services#index'
  get '/api/services/:id', :to => 'api/services#show'
  post '/api/services', :to => 'api/services#create'


  #registration
  post '/api/sign_up', :to => 'api/registration#create', :as => 'create_account'

  # session
  post '/api/session', :to => 'api/session#create', :as => 'create_session'
  post '/api/session/refresh', :to => 'api/session#refresh'

  #admin_enpoints
  get '/api/admin/users', :to => 'api/admin/users#index'
  post '/api/admin/users/confirm', :to => 'api/admin/users#confirm'
  post '/api/admin/users/delete', :to => 'api/admin/users#delete'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
