class SessionsController < ApplicationController

  def login_form
  end

  def login
    # puts params
    user = User.find_by(username: params[:name])

    if user
      # puts user.id
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      session[:logged_in_as_user] = user.id
      # puts "Successfully logged in as existing user #{User.find(session[:logged_in_as_user]).username}"
      redirect_to root_path
    else
      user = User.new(username: params[:name])
      if user.save
        session[:logged_in_as_user] = user.id
        flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
        redirect_to root_path
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        render login_path, status: bad_request
      end
    end
  end

  def logout
    flash[:success] = "Successfully logged out"
    session[:logged_in_as_user] = nil
    redirect_to root_path
  end
end
