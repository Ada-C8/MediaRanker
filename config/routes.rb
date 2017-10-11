Rails.application.routes.draw do
  # get 'main/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :works

  root "main#index"

  get 'login', to: "users#login_form", as: 'login'
  post 'login', to: 'users#login'
end
