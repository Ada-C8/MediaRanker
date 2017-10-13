class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    existing_user= User.find_by(username: params[:username])
    @user = User.new user_params

    if existing_user
      flash[:success] = "Successfully logged in as existing user #{existing_user.username}"
      redirect_to root_path
    elsif @user.save
      flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      redirect_to root_path
    else
      render :new
    end 
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
