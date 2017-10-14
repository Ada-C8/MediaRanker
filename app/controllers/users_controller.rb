class UsersController < ApplicationController

  def index
    @users = Users.all
  end

  def show
    @user = User.find(param [:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
