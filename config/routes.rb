Rails.application.routes.draw do
  root to: 'works#home'

  get '/works/home', to: 'works#home', as: 'home' # home_path

  get '/works', to: 'works#index', as: 'works' # works_path

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work' # edit_work_path

  get '/works/new', to: 'works#new', as: 'new_work' # new_work_path

  get '/works/:id', to: 'works#show', as: 'work' # work_path

  post '/works/:id/create', to: 'works#create', as: 'create_work' # create_work_path

  patch '/works/:id/update', to: 'works#update', as: 'update_work' # update_work_path

  delete 'works/:id/destroy', to: 'works#destroy', as: 'destroy_work' # destroy_work_path

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
