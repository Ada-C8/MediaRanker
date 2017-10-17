Rails.application.routes.draw do
  root to: "works#home", as: "root"

  resources :users, only: [:index, :show, :create] do
    resources :votes, only: [:create]
  end

  resources :votes, only: [:create]

  resources :works do
    resources :votes, only: [:create]
  end

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'

end
