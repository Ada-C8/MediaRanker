Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'works#home'

  resources :works

  resources :users, only:[:new, :create]

  get '/login', to: 'sessions#login_form'

  post '/login', to: 'sessions#login'
  
end
