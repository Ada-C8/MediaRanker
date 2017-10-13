Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :works
  resources :users, except: [:edit, :update, :delete]
  resources :votes,  only: [:new, :create]
  root 'home#index'
end
