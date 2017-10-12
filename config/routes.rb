Rails.application.routes.draw do
  resources :users, only: [:index]
  resources :works, only: [:index, :show, :edit, :update, :create, :destroy]
  # resources :votes

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
