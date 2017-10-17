Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :works
  resources :users, only: [:index, :create, :show]

  post '/votes/:work_id', to: 'votes#create', as: 'votes'
  root 'home#index'

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout', as: 'logout'
end
