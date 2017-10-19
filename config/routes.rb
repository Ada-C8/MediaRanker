Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'works#main'

  resources :users, only: [:index, :show]
  resources :sessions
  resources :works

  get    '/login',   to: 'sessions#login'
  post   '/login',   to: 'sessions#create'
  post   '/logout',  to: 'sessions#logout'
  post   '/works/:id/upvote', to: 'works#upvote', as: 'upvote'
end
