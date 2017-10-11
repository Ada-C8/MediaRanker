Rails.application.routes.draw do
  get 'upvotes/create'

  # get 'users/index'
  #
  # get 'users/show'
  #
  # get 'works/index'
  #
  # get 'works/new'
  #
  # get 'works/edit'
  #
  # get 'works/create'
  #
  # get 'works/show'
  #
  # get 'works/update'
  #
  # get 'works/destroy'
  #
  # get 'main_page/index'
  root to: 'main_page#index'

  post 'works/:id/upvote', to: 'upvotes#create', as: 'create_upvote'

  resources :works
  resources :users

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'

end
