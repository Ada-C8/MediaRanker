Rails.application.routes.draw do

  root 'main#index'


  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout', as: 'logout'

  get 'topten', to: 'works#topten', as: 'topten'

  resources :users

  resources :works
    resources :votes, only: [:new, :create]

  
end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
