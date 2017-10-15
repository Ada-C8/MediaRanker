Rails.application.routes.draw do
  root to: 'works#home'

  get '/home', to: 'works#home', as: 'home'

  resources :works

  get '/users/', to: 'users#index', as: 'users' #users_path

  get '/users/new', to: 'users#new', as: 'new_user'

  get '/users/:id', to: 'users#show', as: 'user'

  post '/users', to: 'users#create', as: 'create_user'

  get '/login', to: 'sessions#login_page'

  post '/login', to: 'sessions#login'

  delete '/login', to: 'sessions#logout'

  post '/works/:id/votes', to: 'votes#create', as: 'new_vote'

  resources :votes, only: [:show, :new]

  # get '/works', to: 'works#index', as: 'works'
  #
  # get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  #
  # get '/works/:id', to: 'works#show', as: 'work'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
