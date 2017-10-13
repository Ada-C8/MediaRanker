class UsersController < ApplicationController

  before_action :find_user_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @user.join_date = DateTime.now
    if save_and_flash(@user)
      redirect_to root_path
    else
      render :login_form, status: :bad_request
    end
  end

  # def login_form
  # end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user.id
      flash[:success] = "#{ user.name } is successfully logged in"
      redirect_to root_path
    else
      create
      session[:logged_in_user] = user.id
    end
  end

  def logout
  	session[:logged_in_user] = @user = nil
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
