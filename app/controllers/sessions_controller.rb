class SessionsController < ApplicationController
  def login_form
  end

  def login
    @user = User.find_by(username: params[:username])
      if @user
        flash[:success] = "Successfully logged in as #{@user.username}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        @user = User.create(username: params[:username])
        if @user
          session[:user_id] = @user.id
          flash[:success] = "Successfully created user #{@user.username}"
          redirect_to root_path
        end
      end
  end

  def log_out
    @user = User.find_by(username: params[:username])
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
