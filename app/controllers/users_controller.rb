class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new users_params
    if @user.save
      flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def users_params
    return params.require(:user).permit(:username)
  end
end
