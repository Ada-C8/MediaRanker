Rails.application.routes.draw do

  root to: "home#index"
  root to: "work#index"
  root to: "vote#index"
  root to: "user#index"

  resources :works
  resources :users
  resources :votes

  resources :home, only: [:index]

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'

  # get 'votes/index'
  # get 'votes/show'
  # get 'votes/create'
  # get 'votes/update'
  # get 'votes/destroy'
  # get 'votes/edit'
  # get 'votes/new'

  # get 'users/index'
  # get 'users/show'
  # get 'users/create'
  # get 'users/update'
  # get 'users/destroy'
  # get 'users/edit'
  # get 'users/new'

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
