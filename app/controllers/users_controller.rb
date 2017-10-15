class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:logged_in_user] = user.id
      redirect_to root
    else
      head :not_found
    end
  end
end
