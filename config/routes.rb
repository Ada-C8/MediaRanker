Rails.application.routes.draw do

get '/', to: 'main#index', as: 'root'

resources :works

resources :users

resources :votes


end
