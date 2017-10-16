Rails.application.routes.draw do

  post '/votes', to: "votes#create"

  post '/logout', to: 'sessions#logout'

  get '/users', to: "users#index"

  get '/users/:id', to: "users#show", as: "user"

  get '/login', to: 'sessions#log_form'

  post '/login', to: 'sessions#login'

  delete '/login', to: 'sessions#destroy'

  root to: 'works#home'

  get 'works/home'

  get 'users/index'

  get 'users/new'

  get 'users/show'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  get 'votes/index'

  get 'votes/new'

  get 'votes/show'

  get 'votes/create'

  get 'votes/edit'

  get 'votes/update'

  get 'votes/destroy'

  get 'homes/index'


  # this code is the same as all of the down below code :D
  #   Rails.application.routes.draw do
  get 'sessions/log_form'

  get 'sessions/login'

  get 'sessions/logout'

  get 'sessions/destroy'

  get 'works/home'

  get 'users/index'

  get 'users/new'

  get 'users/show'

  get 'users/create'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  get 'votes/index'

  get 'votes/new'

  get 'votes/show'

  get 'votes/create'

  get 'votes/edit'

  get 'votes/update'

  get 'votes/destroy'

  get 'homes/index'

  #   resources :works
  # end

  get '/works', to: 'works#index', as: 'works' #works_path

  get 'works/:id/edit', to: 'works#edit', as: 'edit_work' #edit_work_path

  get '/works/new', to: 'works#new', as: 'new_work' #new_work_path

  get '/works/:id', to: 'works#show', as: 'work' #work_path

  patch '/works/:id', to: 'works#update', as: 'update_work' #update_work_path

  post '/works', to: 'works#create', as: 'create_work' #create_work_path

  delete 'works/:id', to: 'works#destroy', as: 'delete_work' #delete_work_path
  #added /:id to /works
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
