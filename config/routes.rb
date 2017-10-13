Rails.application.routes.draw do
  root to: 'works#home'

  get '/users', to: 'users#index', as: 'users' # users_path

  get '/users/:id/show', to: 'users#show', as: 'user' # user_path

  get '/users/new', to: 'users#new', as: 'new_user' # new_user_path

  post '/users', to: 'users#create', as: 'create_user' # create_user_path


  get '/works/home', to: 'works#home', as: 'home' # home_path

  get '/works', to: 'works#index', as: 'works' # works_path

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work' # edit_work_path

  get '/works/new', to: 'works#new', as: 'new_work' # new_work_path

  get '/works/:id', to: 'works#show', as: 'work' # work_path

  post '/works', to: 'works#create', as: 'create_work' # create_work_path

  patch '/works/:id', to: 'works#update', as: 'update_work' # update_work_path

  delete '/works/:id', to: 'works#destroy', as: 'delete_work' # delete_work_path

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
