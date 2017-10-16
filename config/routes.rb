Rails.application.routes.draw do
  root to: 'works#home'

  get '/home', to: 'works#home', as: 'home'

  # get '/votes/', to: 'votes#index'


  patch '/works/:id/upvote', to: 'works#upvote', as: 'upvote'


  get '/works', to: 'works#index', as: 'works'

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'

  patch '/works/:id', to: 'works#update', as: 'update_work'

  get '/works/new', to: 'works#new', as: 'new_work'

  post '/works', to: 'works#create', as: 'create_work'

  get '/works/:id', to: 'works#show', as: 'work'

  delete '/works/:id', to: 'works#destroy'


  get '/users', to: 'users#index', as: 'users'

  get '/users/:id', to: 'users#show', as: 'user'



  get '/login', to: 'users#login_form', as: 'login_form'

  post '/login', to: 'users#login', as: 'login'

  delete '/login', to: 'users#logout', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
