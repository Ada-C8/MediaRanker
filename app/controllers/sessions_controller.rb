class SessionsController < ApplicationController
  def login_form
    #empty, because rails will complain if this doesn't exist
  end
  def login
    user = User.find_by(username: params[:username])
    if user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      user = User.create(username: params[:username])
      flash[:success] = "Successfully created new user #{user.username}"
      session[:user_id] = user.id
      redirect_to root_path
    end
  end
  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
end
