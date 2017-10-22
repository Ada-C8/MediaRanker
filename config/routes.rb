Rails.application.routes.draw do

  root to: "works#top_media"

  resources :users
  get "login", to: "users#login", as: "login"
  # post "login", to: "users#login"
  # delete "logout", to: "users#logout", as: "logout"

  resources :works
  get "top_media", to: "works#top_media", as: "top_media"

  resources :votes

  get '/auth/:provider/callback', to: 'users#login', as: 'auth_callback'
  get 'logout', to: 'users#logout', as: "logout"
  # get 'users/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
