class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    unless @user
      return head :not_found
    end
  end

  def process_login
    user = User.find_by(name: params[:username])

    if user
      session[:user] = user
      flash[:status] = :success
      flash[:message] = "Logged in as #{user.name}"
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
      flash[:status] = :success
      flash[:message] = "User created"
      return redirect_to root_path
    else
      flash[:status] = :failure
      flash[:message] = "Could not create user:"
      flash[:details] = user.errors.messages
      return render :login
    end
  end

  def logout
    session[:user] = nil
    return redirect_to root_path
  end

  # private
end
