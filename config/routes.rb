Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users, only: [:index, :show]

  resources :works
  post '/vote', to: 'votes#create', as: 'create_vote'

  # get '/login', to: 'users#login_form', as: 'login'
  # post '/login', to: 'users#login'

  get 'auth/:provider/callback', to: 'users#login'

  post '/logout', to: 'users#logout', as: 'logout'
end
