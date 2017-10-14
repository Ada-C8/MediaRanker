class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    find_user_by_params_id
  end

  def login
    # get username from for_tag/browser and see if it exists already
    user = User.find_by(username: params[:username])

    if user
      # if user exists already
      session[:logged_in_user] = user
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{user.username}"
      redirect_to root_path
    else
      # create new user
      create
    end
  end

  def create
    user = User.new(username: params[:username])
    if user.save
      session[:logged_in_user] = user
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{user.username} with ID #{user.id}"
      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:message] = "A problem occurred: Could not log in"
      flash[:details] = user.errors.messages
      render :login_form, status: :bad_request
    end
  end

  def logout
    # reset session
    session[:logged_in_user] = nil
    flash[:message] = "Successfully logged out"
    flash[:status] = :success
    redirect_to root_path
  end

private
  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
    return @user
  end

  def user_params
    return params.require(:user).permit(:username)
  end
end
