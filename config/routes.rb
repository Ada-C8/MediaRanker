Rails.application.routes.draw do

  root to: 'works#home'

  resources :works

  get '/login', to: 'sessions#login_form'
  post '/login', to: 'sessions#login'

  post 'logout', to: 'sessions#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
