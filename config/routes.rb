Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/users", to: "users#index", as: "users"
  # get "/users/new", to: "users#new", as: "new_user"
  # post "/users", to: "users#create"
  # get "/users/:id", to: "users#show", as: "user"
  # get "/users/:id/edit", to: "users#edit", as: "edit_user"
  # patch "/users/:id", to: "users#update"
  # delete "/users/:id", to: "users#destroy"

  get '/', to: 'main#index', as: 'root'

  resources :users

  resources :votes, only: :create

  resources :works

  resources :sessions, only: [:login,:logout, :create]

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'

  get '/logout', to: 'users#logout', as: 'logout'
  post '/logout', to: 'users#logout'

end
