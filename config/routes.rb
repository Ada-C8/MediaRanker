Rails.application.routes.draw do
  root to: "works#top_media"
  resources :users
  resources :works
  get "top_media", to: "works#top_media", as: "top_media"

  resources :votes

  get "login", to: "users#login_form", as: "login"
  post "login", to: "users#login"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
