Rails.application.routes.draw do
  root to: 'works#top'

  get '/works/top', to: 'works#top', as: 'top_works'
  resources :works
  resources :users
  resources :votes

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'
  
  post 'logout', to: 'users#logout', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
