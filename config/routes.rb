Rails.application.routes.draw do
  get 'votes/index'

  get 'votes/show'

  get 'votes/new'

  get 'votes/create'

  get 'votes/destroy'

  get 'votes/edit'

  get 'votes/update'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'users/destroy'

  get 'users/edit'

  get 'users/update'

  get 'works/index'

  get 'works/show'

  get 'works/create'

  get 'works/new'

  get 'works/destroy'

  get 'works/edit'

  get 'works/update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
