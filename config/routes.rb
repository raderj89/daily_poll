Rails.application.routes.draw do
  root 'pages#home'
  resources :users

  post 'twilio/process_sms' => 'twilio#process_sms'

  post 'pages/show_poll' => 'pages#show_poll'

  namespace :admin do 
    resources :polls do
      collection { post :sort }
    end

    root to: 'dashboard#index'

    post '/polls/new', to: 'polls#create'
    get 'signin', to: 'sessions#new'
    post 'signin', to: 'sessions#create'
    get 'signout', to: 'sessions#destroy', via: 'delete'
  end
end
