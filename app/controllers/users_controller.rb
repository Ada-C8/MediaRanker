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
    # user_id = params[:user][:user_id]
    # user = User.find_by(id: user_id)
    name = params[:user][:name]

    @user = User.find_by(name: name)

    if @user
      session[:logged_in_user] = @user.id
      redirect_to root_path
      # add flash success message
    else
      create
    end
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to root_path
    # add flash success message
  end

end
