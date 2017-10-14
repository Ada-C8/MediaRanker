class SessionsController < ApplicationController

  def login_form

  end

  def login
    user = User.find_by(username: params[:username])

    if user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      session[:user_id] = user.id
      session[:username] = user.username
      redirect_to root_path
    else
      user = User.create(username: params[:username])
      flash[:success] = "successfully created new user #{user.username} with ID #{user.id}"
      redirect_to root_path
    end
  end

  # def logout
  #   session[:user_id] = nil
  # end

end
