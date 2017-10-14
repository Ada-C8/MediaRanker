Rails.application.routes.draw do

get '/', to: 'main#index', as: 'root'

resources :works

resources :users

resources :votes

get '/login', to: 'sessions#login_form', as: 'login'
post '/login', to: 'sessions#login'

delete '/login', to: 'sessions#logout', as: 'logout'

end
