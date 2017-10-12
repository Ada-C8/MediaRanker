Rails.application.routes.draw do
  root to: 'works#home'

  get '/home', to: 'works#home', as: 'home'

  get '/works', to: 'works#index', as: 'works'

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'

  patch '/works/:id', to: 'works#update', as: 'update_work'

  get '/works/new', to: 'works#new', as: 'new_work'

  post '/works', to: 'works#create', as: 'create_work'

  get '/works/:id', to: 'works#show', as: 'work'



  delete '/works/:id', to: 'works#destroy'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
