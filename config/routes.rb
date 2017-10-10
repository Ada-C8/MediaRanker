Rails.application.routes.draw do
  root to: "works#home", as: "root"

  resources :users
  resources :votes
  resources :works
end
