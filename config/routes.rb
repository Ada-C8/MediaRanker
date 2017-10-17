Rails.application.routes.draw do
  get 'home/index'

  # get 'works/index'

resources :works

resources :users, only: [:index, :show]

resources :votes, only: [:create]


get 'login', to: 'users#login_form', as: 'login'
post 'login', to: 'users#login'

post 'logout', to: 'users#logout'

root 'home#index'

end
