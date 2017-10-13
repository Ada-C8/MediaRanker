Rails.application.routes.draw do
  
  root 'main#index'
  resources :users, only: [:index]
  resources :works, only: [:index, :show, :new, :edit, :update, :create, :destroy]
  # resources :votes


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
