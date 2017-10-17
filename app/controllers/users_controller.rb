class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

  end

  def new
  end

  def create
  end

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as #{@user.name}"
      redirect_to root_path
    else
      if User.create(name: params[:name])
        session[:user_id] = User.find_by(name: params[:name]).id
        flash[:success] = "Welcome to Media Ranker! You are now logged in."
        redirect_to root_path
      else
        flash[:error] = "New username not added successfully"
        render :login_form
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
