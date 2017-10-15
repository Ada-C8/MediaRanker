class UsersController < ApplicationController

  def index
    @users = User.left_outer_joins(:votes).distinct.select('users.*, COUNT(votes.*) AS votes_count').group('users.id').order('votes_count')
  end

  def login_form
    @user = User.new
    # if params[:user_id]
    #   @user.user_id = params[:user_id]
    # end
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user # Logs in as an existing user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as an existing user #{username}"
      redirect_to root_path
    else # Creates new user
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

  def show
    if find_user_by_params_id
      redirect_to user_path
    end
  end


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
