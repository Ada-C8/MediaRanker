Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :votes, only: [:new, :create, :destroy]
  resources :users, except:[:show, :index]

  resources :media_instances, :path => 'media_instances/:media_type'
  get '/media_instances/:media_type', to: 'media_instances#get_:media_type'

  root 'main#index'

  get 'login', to: 'user#login', as: 'login'
  post 'login', to:'user#login'



end
