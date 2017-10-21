Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ####### main ######
  root 'main#index'
  ####### main ######

  ####### works ######
  resources :works
  ####### works ######

  ####### users and login ######
  # get 'users', to: 'users#index', as: 'users'
  # get 'users/:id', to: 'users#show', as: 'user'
  resources :users, only: [:index, :show]


  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  get '/logout', to: 'users#logout', as: 'logout'
  ####### users ######

  ####### votes ######
  post '/votes/:work_id', to: 'votes#create', as: 'create_vote'
  ####### votes ######
end
