Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :vote, only: [:new, :create, :destroy]
  resources :user, except:[:show, :index, :destroy]
  resources :media_instance
  root 'main#index'

  get 'login', to: 'users#login', as: 'login'
  post 'login', to:'users#login'
end
