Rails.application.routes.draw do



  root to: "welcome#index"


  resources :users
  resources :votes
  resources :works do
    resources :votes
  end

  get '/login', to: 'sessions#login_form' #method name is login_form *login form
  post '/login', to: 'sessions#login' # something to actually log us in
  delete '/login', to: 'sessions#log_out'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
