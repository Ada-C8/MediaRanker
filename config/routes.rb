Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#index'
  resources :works
  resources :users do
    resources :votes, only: [:index, :new]
  end
  # resources :votes
  post '/votes/:user_id/:work_id', to: 'votes#create', as: 'create_vote'

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  get '/logout', to: 'users#logout', as: 'logout'
  #think about logout
end
