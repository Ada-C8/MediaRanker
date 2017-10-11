Rails.application.routes.draw do
  get 'votes/index'

  get '/users/index'

  get '/users/new', to: 'users#new', as: 'new_user'

  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

  post '/users', to: 'users#create', as: 'users'

  patch '/users/:id', to: 'users#update'

  get '/users/:id', to: 'users#show', as: 'user'

  delete '/users/:id', to: 'users#destroy'


  get 'works/index'

  get '/works/new', to: 'works#new', as: 'new_work'

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'

  post '/works', to: 'works#create', as: 'works'

  patch '/works/:id', to: 'works#update'

  get 'works/:id', to: 'works#show', as: 'work'

  delete '/works/:id', to: 'works#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
