Rails.application.routes.draw do
  
  get '/404' => 'home#index'

  get '/service/edit/:id', :to => 'home#index'
  get '/service/petition/edit/:id', :to => 'home#index'
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
  post '/api/services/petition/:id/rate_client', :to => 'api/transaction#rate_client'
  post '/api/services/petition/:id/rate_owner', :to => 'api/transaction#rate_owner'
  patch '/api/services/petition/:id', :to => 'api/transaction#update'
  get '/api/services/petition', :to => 'api/transaction#index'
  get '/api/services/petition/:id', :to => 'api/transaction#show'

  #services
  get '/api/services', :to => 'api/services#index'
  get '/api/services/:id', :to => 'api/services#show'
  post '/api/services', :to => 'api/services#create'
  patch '/api/services/:id', :to => 'api/services#update'

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
