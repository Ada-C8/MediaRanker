class SessionsController < ApplicationController

  def login_form
  end

  def login
    user = User.find_by(username: params[:username])
    if user != nil
      session[:user_id] = user.id
      flash[:success] = "#{user.username} is successfully logged in"
    else
      new = User.create(username: params[:username])
      session[:user_id] = new.id
      flash[:success] = "#{new.username} is successfully logged in"
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

end
