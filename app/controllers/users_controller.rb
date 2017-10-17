class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id].to_i)

    head :not_found unless @user
  end

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:username])

    if user
      session[:username] = user.id
      flash[:success] = "#{ user.username } is successfully logged in"
      redirect_to root_path
    else
      user = User.create(username: params[:username])
      flash[:success] = "Successfully created new user #{ params[:username] } with ID #{ user.id }"
      session[:username] = user.id
      redirect_to users_path
    end
  end

  def destroy
    session[:username] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

end
