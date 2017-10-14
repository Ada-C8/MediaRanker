Rails.application.routes.draw do
  # get '/', to: 'work#index', as: 'root'
  root 'main#index'


  # resources :works
  # post '/work/:id/voted_for', to: 'work#voted_for', as: 'vote_counted'


  # resources :authors, only: [:index, :new, :create] do
  #   resources :books, only: [:index, :new]
  # end

  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'

  get 'votes/index'

  get '/votes/new', to: 'votes#new', as: 'new_vote'

  get '/votes', to: 'votes#create', as: 'votes'


  get '/users/index'

  get '/users/new', to: 'users#new', as: 'new_user'

  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'

  post '/users', to: 'users#create', as: 'users'

  patch '/users/:id', to: 'users#update'

  get '/users/:id', to: 'users#show', as: 'user'

  delete '/users/:id', to: 'users#destroy'


  get 'works/index'

  get '/works/new', to: 'works#new', as: 'new_work'

  get '/works/topten', to: 'works#topten', as: 'topten'

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'

  post '/works', to: 'works#create', as: 'works'

  patch '/works/:id', to: 'works#update'

  get 'works/:id', to: 'works#show', as: 'work'

  delete '/works/:id', to: 'works#destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
