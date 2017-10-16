Rails.application.routes.draw do
  resources :users, :works, :votes
  root to: 'main_page#index'

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'
  post '/logout', to: 'sessions#logout'

  # get 'main_page/index'
  #
  # get 'works/index'
  #
  # get 'works/show'
  #
  # get 'works/edit'
  #
  # get 'works/update'
  #
  # get 'works/new'
  #
  # get 'works/create'
  #
  # get 'works/destroy'
  #
  # get 'votes/index'
  #
  # get 'votes/show'
  #
  # get 'votes/edit'
  #
  # get 'votes/update'
  #
  # get 'votes/new'
  #
  # get 'votes/create'
  #
  # get 'votes/destroy'
  #
  # get 'users/index'
  #
  # get 'users/show'
  #
  # get 'users/edit'
  #
  # get 'users/update'
  #
  # get 'users/new'
  #
  # get 'users/create'
  #
  # get 'users/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
