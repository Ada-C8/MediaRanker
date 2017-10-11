Rails.application.routes.draw do

  get '/works', to: 'works#index'

  get '/works/:id', to: 'works#show', as: 'work'

  get 'works/edit'

  get 'works/update'



  get 'works/create'

  get 'works/new'

  get 'works/destroy'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
