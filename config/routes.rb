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
end
