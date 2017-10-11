Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users
  resources :works
  resources :votes, only: [:new, :create]

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'

end
