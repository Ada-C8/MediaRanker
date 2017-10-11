Rails.application.routes.draw do

  root to: "home#index"
  root to: "work#index"

  resources :home, only: [:index]

  resources :works

  # get 'home/index'
  # get 'works/index'
  # get 'works/show'
  # get 'works/create'
  # get 'works/update'
  # get 'works/destroy'
  # get 'works/edit'
  # get 'works/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
