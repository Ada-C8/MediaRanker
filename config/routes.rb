Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :works
  resources :users, only: [:index, :show, :create]
  root 'main#index'

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
end
