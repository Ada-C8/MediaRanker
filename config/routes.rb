Rails.application.routes.draw do

  root to: "works#home", as: "root"

  resources :works do
    resources :votes, only: [:create]
  end 

  resources :users

  resources :votes, except: [:create]

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
