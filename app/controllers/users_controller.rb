require 'date'
class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create_user
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:username])

    if @user
      session[:username] = @user.id
      flash[:success] = "#{ @user.username } is successfully logged in"
      redirect_to root_path
    else
      @user = User.create(username: params[:username])
      flash[:success] = "Successfully created new user #{ params[:username] } with ID #{ @user.id }"
      session[:username] = @user.id
      redirect_to users_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Successfully logged out'
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :joined_on)
  end
end
