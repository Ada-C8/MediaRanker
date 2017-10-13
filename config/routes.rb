Rails.application.routes.draw do
  #root 'home#index'
  get '/works', to: 'works#index', as: 'works'
#  get '/albums', to: 'albums#index', as: 'albums'
  get '/works/new', to: 'works#new', as: 'new_work'
  post '/works', to: 'works#create'
  get '/albums/:id', to: 'albums#show', as: 'album'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  get '/books/:id', to: 'books#show', as: 'book'
  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  patch '/works/:id', to: 'works#update'
  delete '/works/:id', to: 'works#destory'

#  root 'works#index'
  resources :users, :books, :movies, :albums

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
