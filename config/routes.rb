Rails.application.routes.draw do

root 'main#index'

resources :works
resources :users, only: [:index, :show, :create]
end
