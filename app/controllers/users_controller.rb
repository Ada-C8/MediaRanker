class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  def index
    @users = User.all
  end

  def show
    unless @user
      render_404
    end
  end

  def login_form
  end

  def login
    if logged_in?
      flash[:error] = "You are already logged in as #{User.find_by(id: session[:user_id].to_i).username}"
      return redirect_to root_path
    end
    return existing_user_login if user_exists?
    create_user
  end

  def logout
    if logged_in?
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    end
    redirect_to root_path
  end

  private
  def find_user
    @user = User.find_by(id: params[:id].to_i)
  end

  def logged_in?
    return session[:user_id] != nil
  end

  def user_exists?
    @user = User.find_by(username: params[:username])
    return @user != nil
  end

  def existing_user_login
    session[:user_id] = @user.id
    flash[:success] = "Successfully logged in as existing user #{ @user.username }"
    redirect_to root_path
  end

  def create_user
    new_user = User.new(username: params[:username])
    if new_user.save(username: params[:username])
      session[:user_id] = new_user.id
      flash[:success] = "Successfully created new user #{params[:username]} with ID #{new_user.id}"
      redirect_to root_path
    else
      flash.now[:error] = "Username #{params[:username]} was not created"
      render :login_form
    end
  end
end
