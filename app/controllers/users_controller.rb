class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    strong_params = user_params
    @user = User.new(strong_params)
    @user.save
    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(strong_params)
    @user.save
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    redirect_to users_path
  end

private
  def user_params
    return params.require(:user).permit(:name)
  end

end
