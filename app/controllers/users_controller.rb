class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    find_user_by_param
  end

  def process_login
    user = User.find_by(name: params[:username])

    if user
      session[:user] = user
      return redirect_to root_path
    else
      create
    end
  end

  def create
    user = User.new(name: params[:username])
    if user.valid?
      user.save
      session[:user] = user
      return redirect_to root_path
    else
      return render login_path
    end
  end

  def logout
    session[:user] = nil
    return redirect_to root_path
  end

  private

  def find_user_by_param
    @user = User.find_by(id: params[:id])

    unless @user
      return head :not_found
    end
  end
end
