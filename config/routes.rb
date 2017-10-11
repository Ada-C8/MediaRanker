Rails.application.routes.draw do
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
  resources :works
  resources :users

end
