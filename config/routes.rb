Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ###### Works ######
  # # VERB    PATH    # CONTROLLERACTION   PREFIX
  # get "/works", to: "works#index", as: "works"

  # get "/works/new", to: "works#new", as: "new_work"
  # post "/works", to: "works#create" YES
  #
  # get "/works/:id", to: "works#show", as: "work"
  #
  # get "/work/:id/edit", to: "works#edit", as: "edit_work"
  # patch "/works/:id", to: "works#update"
  #
  # delete "/work/:id", to: "works#destroy"
  resources :works

  resources :votes

  resources :users
end
