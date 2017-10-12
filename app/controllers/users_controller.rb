class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def process_login
    @user = User.find_by(name: params[:username])

    if @user
      session[:user] = @user
      return redirect_to root_path
    else
      create(@user)
    end
  end

  def create(user)
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
end
