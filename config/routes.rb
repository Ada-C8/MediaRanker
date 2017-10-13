Rails.application.routes.draw do
  # get 'works/index'

resources :works

resources :users, only: [:index, :show] 


get 'login', to: 'users#login_form', as: 'login'
post 'login', to: 'users#login'

end
