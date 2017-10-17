Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'works#main', as: "root"
  resources :works

  resources :users, only: [:index, :show]
  get 'login', to: 'users#create_user', as: 'login'
  post 'login', to: 'users#login'
  delete 'logout',  to: 'users#destroy', as: 'logout'
end
