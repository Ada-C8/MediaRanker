Rails.application.routes.draw do
  root to: 'works#homepage'

  post 'works/:id/vote', to: 'votes#create', as: 'vote'
  resources :works

  resources :users

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  delete '/login', to: 'users#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
