Rails.application.routes.draw do

  root to: "works#home", as: "root"

  resources:works

  resources:users

  resources:votes

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
