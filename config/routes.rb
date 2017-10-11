Rails.application.routes.draw do
  get 'works', to: 'works#index', as: 'works'

  get 'works/new', to: 'works#new', as: 'new_work'

  get 'works/:id/edit', to: 'works#edit', as: 'edit_work'

  get 'works/:id', to: 'works#show', as: 'work'

  patch 'works/:id', to: 'works#update', as: 'update_path'

  post 'works', to: 'works#create', as: 'create_work'

  delete 'works/:id', to: 'works#destroy', as: 'delete_work'

  get 'home', to: 'works#home', as: 'home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
