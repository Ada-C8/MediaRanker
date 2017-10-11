Rails.application.routes.draw do
  # ~~~~~~~~~~~~~~~~ Homepage ~~~~~~~~~~~~~~~~
  root to: 'homepage#index'
  get '/', to: 'homepage#index', as: 'homepage'
  # ~~~~~~~~~~~~~~~~ Works ~~~~~~~~~~~~~~~~
  get '/works', to: 'works#index', as: 'works'
end
