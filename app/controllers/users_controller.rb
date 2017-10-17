class UsersController < ApplicationController
  before_action :find_user_by_params_id, only: [:show]

  def index
    @users = User.all_users_with_vote_count
  end

  def login_form
    @user = User.new
  end


  def login
    username = params[:user][:username]
    if username == ''
      flash[:status] = :failure
      flash[:message] = "Username can not be empty"
      redirect_to login_path
      return
    end
    user = User.find_by(username: username)

    # Logs in as an existing user
    if user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as an existing user #{username}"
      redirect_to root_path
      # Creates new user
    else
      user = User.new(username: username, created_at: Date.today)
      user.save
      flash[:status] = :success
      flash[:message] = "Successfully logged in as #{username}"
      session[:logged_in_user] = user.id
      redirect_to root_path
    end
  end

  def logout
    session[:logged_in_user] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

  def show ; end


  private

  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end
end
