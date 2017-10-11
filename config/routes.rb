Rails.application.routes.draw do
  # ~~~~~~~~~~~~~~~~ Homepage ~~~~~~~~~~~~~~~~
  root to: 'homepage#index'
  get '/', to: 'homepage#index', as: 'homepage'
end
