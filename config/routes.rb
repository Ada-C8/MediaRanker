Rails.application.routes.draw do

  root to: 'works#home'


  get '/users', to: 'users#index', as: 'users' # users_path

  get '/users/:id', to: 'users#show', as: 'user' # user_path

  get '/login', to: 'users#login_form', as: 'login' # login_path

  post '/login', to: 'users#login' # login_path

  post '/logout', to: 'users#logout', as: 'logout' # logout_path


  get '/works/home', to: 'works#home', as: 'home' # home_path

  get '/works', to: 'works#index', as: 'works' # works_path

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work' # edit_work_path

  get '/works/new', to: 'works#new', as: 'new_work' # new_work_path

  get '/works/:id', to: 'works#show', as: 'work' # work_path

  post '/works', to: 'works#create', as: 'create_work' # create_work_path

  patch '/works/:id', to: 'works#update', as: 'update_work' # update_work_path

  delete '/works/:id', to: 'works#destroy', as: 'delete_work' # delete_work_path


  post '/users/:id/upvote', to: 'votes#upvote', as: 'upvote_work' # upvote_work_path

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
