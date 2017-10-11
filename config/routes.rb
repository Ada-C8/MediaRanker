Rails.application.routes.draw do
  # ~~~~~~~~~~~~~~~~ Homepage ~~~~~~~~~~~~~~~~
  root to: 'homepage#index'
  get '/', to: 'homepage#index', as: 'homepage'
  # ~~~~~~~~~~~~~~~~ Works ~~~~~~~~~~~~~~~~
  get '/works', to: 'works#index', as: 'works'
  get '/works/:id', to: 'works#show', as: 'work'
end
