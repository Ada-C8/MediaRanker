class UsersController < ApplicationController
  def index
    @users = User.order(:created_at)
  end

  def show
  end

  def new
  end

  def create
  end

  def login_form
  end

  def login

      user = User.find_by(name: params[:name])
      if user
        session[:user_id] = user.id
        flash[:message] = "Successfully logged in as existing user #{ user.name }"
        redirect_to root_path
      else
        render :login_form
      end
  end
end
