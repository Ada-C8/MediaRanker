Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except:[:show, :index]
  get '/movies', to: 'media_instances#get_movies'
  get '/books', to: 'media_instances#get_books'
  get '/music', to: 'media_instances#get_music'

  resources :media_instances, constraints: { media_type: /book|movie|music/ } , :path => 'media_instances/:media_type'

  resources :media_instances do
    resources :users, only: [:index] do
      resources :votes,  only: [ :create, :destroy]
    end
  end

  root 'main#index'

  get '/login', to: 'users#new', as: 'login'
  post '/login', to:'users#login'
end
