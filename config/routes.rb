Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :edit, :update]
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"
  get "welcome", to: "sessions#welcome"
  get "authorized", to: "sessions#page_requires_login"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "sessions#welcome"
end
