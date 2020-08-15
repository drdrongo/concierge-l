Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :reservations, except: :destroy do
    resources :time_requests, only: %i[ create update ]
    resources :requests, only: %i[ create update ]
    resources :hotel_amenities, only: :index
    resources :messages, only: :create
  end
  resources :articles, only: %i[ show ]

  namespace :staff do 
    root 'reservations#index'
    resources :reservations, only: %i[ index show update ] do
      resources :messages, only: :create
      resources :time_requests, only: %i[ create update ]
      resources :requests, only: %i[ create update ]
    end
  end
end
