Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#index'

  resources :works
  resources :users, only:[:index, :show]

  get '/login', to: 'users#login', as: 'login'
  post '/login', to: 'users#process_login'
  get '/logout', to: 'users#logout', as: 'logout'
end
