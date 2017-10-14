class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # def new
  #   @user = User.new
  # end

  def create # Add Strong Params
    @user = User.new(
      name: params[:user][:name]
    )
    @user.save

    flash[:status] = :success
    flash[:message] = "Successfully Logged in as #{@user.name}"

    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
  end

  # def update
  #   @user = User.find(param[:id])
  #   # Do I need to update the user at this time?
  # end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  # end
end
