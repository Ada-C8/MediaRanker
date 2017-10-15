Rails.application.routes.draw do
  resources :users
  resources :works
  resources :votes
  # get "/login", to: "SessionsController#new", as: "login"
  # post "/login", to: "SessionsController#create", as: "create_login"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
