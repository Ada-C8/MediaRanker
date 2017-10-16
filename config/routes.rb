Rails.application.routes.draw do

  get 'users/index'

root 'main#index'

resources :works
resources :users, only: [:index, :show, :create]
end
