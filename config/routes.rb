Rails.application.routes.draw do

  root to: 'works#home', as: 'root' #root_path

  get 'works', to: 'works#index', as: 'works'

  get 'works/new', to: 'works#new', as: 'new_work'

  get 'works/:id/edit', to: 'works#edit', as: 'edit_work'

  get 'works/:id', to: 'works#show', as: 'work'

  patch 'works/:id', to: 'works#update', as: 'update_path'

  post 'works', to: 'works#create', as: 'create_work'

  delete 'works/:id', to: 'works#destroy', as: 'delete_work'

  get 'users', to: 'users#index', as: 'users'

  get 'users/new', to: 'users#new', as: 'new_user'

  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'

  get 'users/:id', to: 'users#show', as: 'user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
