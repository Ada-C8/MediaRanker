Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destory', as: 'logout'
  get 'signup', to: 'users#new', as: 'signup'
  post '/works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  root 'home#index'

  resources :users, only: [:index, :show, :new, :create]
  resources :sessions, :works

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
