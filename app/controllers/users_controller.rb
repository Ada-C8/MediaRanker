class UsersController < ApplicationController

  before_action :find_user_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.join_date = DateTime.now
    if @user.save
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully created a new user #{user.username} with ID #{user.id}"
      redirect_to root_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to log in"
      render :login_form, status: :bad_request
      return
    end
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user.id
      save_and_flash(user)
      flash[:message] = "#{ user.name } has successfully logged in"
    else
      create
      session[:logged_in_user] = user.id
    end
    redirect_to root_path
  end

  def logout
  	session[:logged_in_user] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

  def show ; end

  def edit ; end

  def update
    @user.update_attributes(user_params)
    if save_and_flash(@user)
      redirect_to user_path(@user)
      return
    else
      render :edit, status: :bad_request
      return
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end
end
