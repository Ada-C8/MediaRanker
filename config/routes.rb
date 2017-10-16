Rails.application.routes.draw do

  resources :works
  resources :users, only: [:index, :show]
  resources :votes, only: [:new]
  root 'main#index'

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout', as: 'logout'


end
