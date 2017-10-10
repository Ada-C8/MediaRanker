Rails.application.routes.draw do
  get '/users/index'

  get '/users/new', to: 'users#new', as: 'new_user'

  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

  post '/users', to: 'users#create', as: 'users'

  patch '/users/:id', to: 'users#update'

  get '/users/:id', to: 'users#show', as: 'user'

  delete '/users/:id', to: 'users#destroy'


  get 'works/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
