class SessionsController < ApplicationController

  def login_form

  end

  #ex syntax to check session info
  # session[:user_id]

  def login
    if user = User.find_by(name: params[:name])
      flash[:success] = "Successfully logged in as existing user #{user.name}"
      session[:user_id] = user.id
      session[:name] = user.name
      redirect_to root_path
    else
      user = User.new(name: params[:name])
      if user.save
        flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}"
        session[:user_id] = user.id
        session[:name] = user.name
        redirect_to root_path
      else
        flash[:error] = "Could not log user in"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end


end
