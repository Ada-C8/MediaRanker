Rails.application.routes.draw do

  root to: 'works#home', as: 'root' #root_path

  get 'works', to: 'works#index', as: 'works'

  get 'works/new', to: 'works#new', as: 'new_work'

  get 'works/:id/edit', to: 'works#edit', as: 'edit_work'

  get 'works/:id', to: 'works#show', as: 'work'

  patch 'works/:id', to: 'works#update', as: 'update_work'

  post 'works', to: 'works#create', as: 'create_work'

  delete 'works/:id', to: 'works#destroy', as: 'delete_work'

  get 'users', to: 'users#index', as: 'users'

  get 'users/:id', to: 'users#show', as: 'user'

  get 'login', to: 'sessions#login_form', as: 'login'

  post 'login', to: 'sessions#login'

  get 'logout', to: 'sessions#logout'

  get "/auth/:provider/callback", to: "sessions#create"

  post 'votes', to: 'votes#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
