Rails.application.routes.draw do
  root to: 'works#home'

  get '/home', to: 'works#home', as: 'home'

  get '/works', to: 'works#index', as: 'works'

  get '/works/:id/edit', to: 'works#edit', as: 'edit_work'

  get '/works/:id', to: 'works#show', as: 'work'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
