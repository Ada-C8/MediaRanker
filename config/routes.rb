Rails.application.routes.draw do

  root to: 'works#homepage'

  get '/users', to: 'users#index', as: 'users'

  get '/users/:id', to: 'users#show', as: 'user'

  get '/login', to: 'sessions#login_form', as: 'login'

  post '/login', to: 'sessions#login'

  post '/logout', to: 'sessions#logout'

  resources :works

  # directs non-valid pages to 404.html
  get '*path' => redirect('/404.html')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
