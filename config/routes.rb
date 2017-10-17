Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "home#index"

  resources :works

  resources :votes

  resources :users

  get "login", to: "users#login_form", as: "login"
  post "login", to: "users#login"
  get "logout", to: "users#logout", as: "logout"

  get "work/:id/votes", to: "votes#create", as: "create_vote"
  post "work/:id/votes", to: "votes#create"

end
