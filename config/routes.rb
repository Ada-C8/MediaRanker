Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except:[:show, :index]

  # post '/login', to:'users#login'
  get '/logout', to: 'users#logout'



  resources :media_instances do
    resources :users, only: [:index] do
      resources :votes,  only: [ :create, :destroy]
    end
  end
  
  resources :media_instances, constraints: { media_type: /book|movie|music/ } , :path => 'media_instances/:media_type'

  get '/movies', to: 'media_instances#get_movies'
  get '/books', to: 'media_instances#get_books'
  get '/music', to: 'media_instances#get_music'

  get '/auth/:provider/callback', to: 'users#login',  as: 'login'
  root 'main#index'

  # get '/login', to: 'users#new', as: 'login'

end
