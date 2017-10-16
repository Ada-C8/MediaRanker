Rails.application.routes.draw do
  
  root to: 'works#home'

  get '/works/home'
  resources :works

  resources :users, only: [:index, :show]

  resources :votes, only: [:create]

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
