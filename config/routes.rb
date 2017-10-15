Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'main#index'
  get "main/index"

  resources :works do
     resources :votes, only: [:create]
   #post '/votes', to: 'work#vote'
  #   # resources :votes, only: [:new]
   end

  # resources :works
  resources :users, only: [:index, :show, :login, :logout]
  resources :votes


  get 'login', to: 'sessions#login_form', as: 'login'
  post 'login', to: 'sessions#login'
  get 'logout', to: 'sessions#logout', as: 'logout'



end
