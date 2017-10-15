Rails.application.routes.draw do
  root 'home#index'

  resources :works

  get "/login", to: "sessions#login_form"
  post "/login", to: "sessions#login"
  delete "/logout", to: "sessions#logout"

  resources :users, except: [:destroy, :edit, :update, :new]

  post "/works/:work_id/upvote", to:"votes#create", as: "vote"


end
