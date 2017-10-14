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

  resources :users, except: [:update, :destroy, :new]

  resources :votes, only: :create

  resources :works

  resources :sessions, only: [:login,:logout]

  get '/login', to: 'sessions#login', as: 'login'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#logout', as: 'logout'
  post '/logout', to: 'sessions#logout'

end
