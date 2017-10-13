class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
  end

  def create
  end


  def login_form

  end

  def login
    username = params[:user][:username]
    user = User.find(username: username)

    if user
      session[:logged_in_user] = user.id
      flash[:success] = "#{ user.username } is successfully logged in"
      redirect_to root_path
    end
  end
end
