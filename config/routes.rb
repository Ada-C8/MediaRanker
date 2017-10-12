Rails.application.routes.draw do
  root to: 'works#index'

  get '/works/top', to: 'works#top', as: 'top_works' 
  resources :works
  resources :users
  resources :votes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
