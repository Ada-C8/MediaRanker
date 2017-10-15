class SessionsController < ApplicationController
  def login_form
    if session[:user] != nil # if a user's already logged in
      flash[:error] = "Already logged in as user #{session[:user]["username"]}"
      redirect_to root_path
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user.nil? # user doesn't exist yet
      user = User.new(username: params[:username])
      user.save
      flash[:success] = "#{ user.username } is created and successfully logged in"
    else # user already exists
      flash[:success] = "Successfully logged in as existing user #{ user.username }"
    end
    session[:user] = user
    redirect_to root_path
  end

end
