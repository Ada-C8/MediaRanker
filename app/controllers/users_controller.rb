class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
      flash[:success] = "Successfully added #{@user.name} to the database"
      session[:logged_in_user] = @user
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:user][:name])

    if @user
      session[:logged_in_user] = @user
      redirect_to users_path
    else
      create
    end

    flash[:success] = "Successfully logged in as #{@user['name']}"
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to users_path
    flash[:success] = "You've been logged out"
  end

private
  def user_params
    params.require(:user).permit(:name)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
