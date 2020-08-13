Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :reservations, except: :destroy do
    resources :time_requests, only: :create
    resources :requests, only: :create
    resources :hotel_amenities, only: :index
    resources :messages, only: :create
  end
  resources :articles, only: %i[ show ]

  namespace :staff do 
    root 'reservations#index'
    resources :reservations, only: %i[ index show ] do
      resources :messages, only: :create
    end
  end
end
