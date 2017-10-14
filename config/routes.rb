Rails.application.routes.draw do

  get 'sessions/new'

  root 'main#index'
  resources :users, only: [:index, :show, :new]
  get 'login', to: 'users#login_form', as:'login'
  post 'login', to: 'users#login'
  resources :works, only: [:index, :show, :new, :edit, :update, :create, :destroy]
  # resources :votes


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
