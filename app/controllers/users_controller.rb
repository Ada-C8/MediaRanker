class UsersController < ApplicationController
  before_action :find_user, only: [:login]
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id].to_i)
    unless @user
      render_404
    end
  end

  def login_form
  end

  def login
    if logged_in?
      flash[:error] = "You are already logged in as #{User.find_by(id: session[:user_id].to_i).username}"
      redirect_to root_path
    else
      user = User.find_by(username: params[:username])
      if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as existing user #{ user.username }"
        redirect_to root_path
      else
        user = User.new(username: params[:username])
        if user.save(username: params[:username])
          user = User.find_by(username: params[:username])
          session[:user_id] = user.id
          flash[:success] = "Successfully created new user #{params[:username]} with ID #{user.id}"
          redirect_to root_path
        else
          flash.now[:error] = "Username #{params[:username]} was not created"
          render :login_form
        end
      end
    end
  end

  def logout
    if logged_in?
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
      redirect_to root_path
    end
  end

  private
  def logged_in?
    return session[:user_id] != nil
  end
end
