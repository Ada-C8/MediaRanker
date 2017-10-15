class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      flash[:error] = "That user does not exist."
      redirect_to users_path
    end
  end

  def create
    @user = User.new(username: params[:user][:username])
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

end
