Rails.application.routes.draw do

  resources :works
  resources :users, only: [:index, :show]
  root 'main#index'

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
end
