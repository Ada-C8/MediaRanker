Rails.application.routes.draw do
  # ~~~~~~~~~~~~~~~~ Homepage ~~~~~~~~~~~~~~~~
  root to: 'homepage#index'
  get '/', to: 'homepage#index', as: 'homepage'
  # ~~~~~~~~~~~~~~~~ Works ~~~~~~~~~~~~~~~~
  get '/works', to: 'works#index', as: 'works'
  get '/works/new', to: 'works#new', as: 'new_work'
  post '/works', to: 'works#create', as: 'create_work'
  get '/works/:id', to: 'works#show', as: 'work'
  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  patch '/works/:id', to: 'works#update', as: 'update_work'
  delete '/works/:id', to: 'works#destroy', as: 'delete_work'
  # ~~~~~~~~~~~~~~~~ Users ~~~~~~~~~~~~~~~~
  get '/users', to: 'users#index', as: 'users'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/login', to: 'users#login_form', as: 'login_form'
  post '/login', to: 'users#login', as: 'login'
  get '/logout', to: 'users#logout', as: 'logout'
  # ~~~~~~~~~~~~~~~~ Votes ~~~~~~~~~~~~~~~~
  post '/votes', to: 'votes#create', as: 'create_vote'
end
