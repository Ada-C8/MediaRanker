Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'works/index'

  get 'works/show'

  get 'works/new'

  get 'works/edit'

  get 'works/update'

  get 'works/create'

  get 'works/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
