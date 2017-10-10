Rails.application.routes.draw do

  root to: 'works#index', as: "root"

  # get 'user/index'
  #
  # get 'works/create'
  #
  # get 'works/destroy'
  #
  # get 'works/edit'
  #
  # get 'works/new'
  #
  # get 'works/show'
  #
  # get 'works/update'
  #
  # get 'works/index'

  resources:works

  resources:users

  resources:votes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
