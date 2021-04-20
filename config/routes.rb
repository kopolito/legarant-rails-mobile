Rails.application.routes.draw do
  
  root 'sessions#welcome'

  resources :users, except: [:index, :destroy]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'welcome', to: 'sessions#welcome'
  
  # resources :sessions, only: [:new, :create, :destroy]
  resources :contracts, only: [:index, :show]
  resources :products, only: [:index, :show]
  
  get "*path" => redirect("/")
end
