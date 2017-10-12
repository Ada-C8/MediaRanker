Rails.application.routes.draw do

  get 'homes/index', to: 'homes#index', as: 'home'

  resources:works

  resources:users

  resources:votes

  # get 'votes/new'
  #
  # get 'votes/create'
  #
  # get 'votes/update'
  #
  # get 'votes/edit'
  #
  # get 'votes/destroy'
  #
  # get 'votes/index'
  #
  # get 'votes/show'

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
