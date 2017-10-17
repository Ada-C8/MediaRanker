class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def login_form
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as an existing user #{name}"
      redirect_to root_path
    else
      user = User.new(name: name, created_at: Date.today)
      user.save
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{name} with ID #{user.id}"
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
    find_user_by_params_id
  end
end

def find_user_by_params_id
  @user = User.find_by(id: params[:id])
  unless @user
    head :not_found
  end
  return @user
end
