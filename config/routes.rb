Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'works#home', as: "root"

  resources :works

  resources :users, only: [:index, :show]
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  delete '/logout',  to: 'users#destroy'

  post '/votes/:work_id', to: 'votes#create', as: 'create_vote'
end
