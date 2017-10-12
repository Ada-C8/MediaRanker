Rails.application.routes.draw do
  get 'album/index'

  get 'book/index'

  get 'movie/index'

  get 'user/index'

  get 'layouts/application'

  resources :users, :books, :movies, :albums

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
