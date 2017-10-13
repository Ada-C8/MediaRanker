Rails.application.routes.draw do
  # get 'works/index'

resources :works


get 'login', to: 'users#login_form', as: 'login'
post 'login', to: 'users#login'

end
