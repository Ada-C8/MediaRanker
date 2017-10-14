Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'main#index'
  get "main/index"

  resources :works do
    #resources :votes, only: [:create]
    post '/votes', to: 'work#vote'
    # resources :votes, only: [:new]
  end

  # resources :works
  resources :users
  resources :votes, except: [:create]


  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout', as: 'logout'



end
