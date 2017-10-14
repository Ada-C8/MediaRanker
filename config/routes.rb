Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, except:[:show, :index]
  get '/media_instances/movies', to: 'media_instances#get_movies'
  get '/media_instances/books', to: 'media_instances#get_books'
  get '/media_instances/news', to: 'media_instances#get_news'

  resources :media_instances, constraints: { media_type: /book|movie|news/ } , :path => 'media_instances/:media_type'

  resources :media_instances do
    resources :users, only: [:index] do
      resources :votes,  only: [ :create, :destroy]
    end
  end

  root 'main#index'

  get '/login', to: 'users#new', as: 'login'
  post '/login', to:'users#login'
end
