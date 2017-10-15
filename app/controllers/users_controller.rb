class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.new(name: params[:user][:name])

    if save_and_flash(@user)
      session[:logged_in_user] = @user.id
      redirect_to root_path
    else
      render :login_form, status: :bad_request
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    head :not_found unless @user
  end

  def login_form

  end

  def login
    name = params[:user][:name]

    @user = User.find_by(name: name)

    if @user
      session[:logged_in_user] = @user.id
      redirect_to root_path
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"
    else
      create
      # Successfully created new user aweoituwelgnweb with ID 425
    end
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to root_path
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
  end

end
