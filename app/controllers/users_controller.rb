class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form 
  end

  def login
    username = params[:user][:username]

    user = User.find_by(username: username)

    if user
      session[:logged_in_user] = user.id
      redirect_to works_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "No such user exists."
      render :login_form
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
