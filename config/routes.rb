Rails.application.routes.draw do
  # get '/', to: 'work#index', as: 'root'
  root 'main#index'


  get 'login', to: 'users#login_form', as: 'login'
  post 'login', to: 'users#login'

  resources :users

  resources :works
    resources :votes

  
  get 'upvote', to: 'votes#new', as: 'upvote'
  post 'upvote', to: 'votes#create'


end
# <% if user_signed_in? && current_user.likes?(post) %>
#   <%= link_to "Unlike", post_like_path(post), method: :delete, remote: true %>
# <% else %>
#   <%= link_to "Like", post_like_path(post), method: :post, remote: true %>
# <% end %>
#
# <%= post.likes.count %>
#
# # <% post.likes.each do |like| %>
# #   <%= image_tag like.user.avatar_url, width: 20 %>
# # <% end %>
# <% @posts.each do |post| %>
#   <h3><%= link_to post.title, post %></h3>
#   <div><%= simple_format post.body %></div>
#   <p id="post_<%= post.id %>_likes"><%= render partial: "likes", locals: {post: post} %></p>
#   <hr />
# <% end %>




  # get '/votes/new', to: 'votes#new', as: 'new_vote'
  #
  # get '/votes', to: 'votes#create', as: 'votes'



  # get 'works/:id/upvote', to: 'works#upvote', as: 'upvote_work'
  # get '/works/topten', to: 'works#topten', as: 'topten'
  #
  # get '/votes/new', to: 'votes#new', as: 'new_vote'
  # post '/votes', to: 'votes#create', as: 'votes'

# resources :works
# post '/work/:id/voted_for', to: 'work#voted_for', as: 'vote_counted'


# resources :authors, only: [:index, :new, :create] do
#   resources :books, only: [:index, :new]
# end

  # get '/works/:id/upvote', to: 'works#upvote, '

  # get 'works/index'
  #
  # get '/works/new', to: 'works#new', as: 'new_work'
  #
  #
  #
  # get '/works/:id/edit', to: 'works#edit', as: 'edit_work'
  #
  # post '/works', to: 'works#create', as: 'works'
  #
  # patch '/works/:id', to: 'works#update'
  #
  # get 'works/:id', to: 'works#show', as: 'work'
  #
  # delete '/works/:id', to: 'works#destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


#
# get '/users/index'
#
# get '/users/new', to: 'users#new', as: 'new_user'
#
# get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
#
# post '/users', to: 'users#create', as: 'users'
#
# patch '/users/:id', to: 'users#update'
#
# get '/users/:id', to: 'users#show', as: 'user'
#
# delete '/users/:id', to: 'users#destroy'
