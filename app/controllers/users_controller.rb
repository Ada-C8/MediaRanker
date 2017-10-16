class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def login_form
  end

  def login
    user = User.find_by(username: params[:username].capitalize)
    if user == nil
      user = User.new(username: params[:username].capitalize)
      user.save
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{user.username} with ID #{user.id}"
      redirect_to root_path
    else
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{user.username}"
      redirect_to root_path
    end
  end

  def logout
    # Remove the user id from the session
    session[:logged_in_user] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to request.referrer, notice: "You're being redirected"
  end

  def show
    redirect_to users_path unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    redirect_to user_path unless @user
    if @user.update_attributes user_params
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by_id(params[:id])
  end

end
