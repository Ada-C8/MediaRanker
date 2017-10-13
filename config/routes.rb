Rails.application.routes.draw do
  root to: 'works#home'

  get '/works/home'
  resources :works

  resources :users

  resources :votes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
