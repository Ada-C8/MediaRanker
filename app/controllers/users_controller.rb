class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end

  def new
    @user = User.new
  end

  def create
    strong_params = user_params
    @user = User.new(strong_params)
    if @user.save
      redirect_to root_path
    else
      render :new, status: :bad_request
    end
  end

  def login_form
  end

  def login
    user_name = params[:user][:name]
    user = User.find_by(name: user_name)
    if user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as #{user.name}"
    else
      user = User.create!(name: params[:user][:name])
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully created #{user.name}"
    end
    redirect_to root_path
  end

  def logout
    session[:logged_in_user] = nil
    if session[:logged_in_user] == nil
      flash[:status] = :success
      flash[:message] = "Successfully logged out"
      redirect_to root_path
      return
    else
      flash[:status] = :failure
      flash[:message] = "Could not log you out"
      redirect_to root_path
      return
    end
  end


private
  def user_params
    return params.require(:user).permit(:name)
  end


end
