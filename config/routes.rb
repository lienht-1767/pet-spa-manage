Rails.application.routes.draw do
  get "/service-detail/:id", to: "static_pages#service_detail", :as => :service_detail
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
  namespace :admin do
   resources :comments
   resources :services
  end
end
