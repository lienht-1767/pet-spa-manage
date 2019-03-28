Rails.application.routes.draw do
  get "sessions/new"
  get "/signup", to: "users#new"
  get "/admin", to: "admin/base#home"
  get "/home", to: "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  post "/subscribe", to: "static_pages#order"
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"
  resources :users
  resources :account_activations, only: %i(edit)
  resources :password_resets, except: %i(index show destroy)
  resources :posts, only: %i(index show)
  resources :services, only: %i(index show)
  namespace :admin do
   resources :comments
   resources :services
   resources :posts
  end
end
