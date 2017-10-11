Rails.application.routes.draw do
  root to: "works#home", as: "root"

  resources :users do
    resources :votes, only: [:create]
  end

  resources :votes

  resources :works do
    resources :votes, only: [:create]
  end

  get '/login', to: 'sessions#login'
end
