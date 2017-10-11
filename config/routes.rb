Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :vote, except[:show]
  resources :user
  resources :media_instance
  root 'main#index'
end
