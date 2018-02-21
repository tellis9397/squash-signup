Rails.application.routes.draw do


  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root   'static_pages#home'
  get    '/signup',          to: 'users#new'
  post   '/signup',          to: 'users#create'
  get    '/login',           to: 'sessions#new'
  post   '/login',           to: 'sessions#create'
  delete '/logout',          to: 'sessions#destroy'
  #resources :bookings
  resources :tv_shows
  resources :users
  resources :user_shows
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :users do
    resources :bookings
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
