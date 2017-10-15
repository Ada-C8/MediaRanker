Rails.application.routes.draw do
  resources :users
  resources :works
  resources :votes

  get "login", to: "users#login_form", as: "login"
  post "login", to: "users#login"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
