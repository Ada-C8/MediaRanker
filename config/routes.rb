Rails.application.routes.draw do

  resources :works
  resources :users
  resources :votes

  root 'main#index'

  get('works/:id/votes', to:'votes#create', as: 'work_vote')
  post('works/:id/votes', to: 'votes#create')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
