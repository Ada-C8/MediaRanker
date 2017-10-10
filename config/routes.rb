Rails.application.routes.draw do

  root to: 'works#index'
  # this code is the same as all of the down below code :D
  #   Rails.application.routes.draw do
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
