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

resources :votes

resources :works

post 'works/:id/votes', to: 'votes#create'

# get "/passengers/:id/trips/new", to: "trips#new", as: "new_passenger_trip"

# get 'works/:id/votes/new', to: 'votes#new', as: new_work_vote_path

end
