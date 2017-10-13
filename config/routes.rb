Rails.application.routes.draw do

  get 'users/index'

  get 'users/show'

  root to: 'works#homepage'

  resources :works

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
