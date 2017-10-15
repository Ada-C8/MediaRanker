class SessionsController < ApplicationController

  def login_form
  end

  def login
    user = User.find_by(username: params[:name])

    if user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      session[:logged_in_as_user] = user.id
      redirect_to root_path
    else
      user = User.new(username: params[:name])
      if user.save
        session[:logged_in_as_user] = user.id
        flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
        redirect_to root_path
      else
        flash[:error] = "A problem occurred: Could not log in"
        redirect_back(fallback_location: root_path)
        #BUG redirect_to login_path
        #BUG render :login_form, status: :no_content
      end
    end
  end

  def logout
    flash[:success] = "Successfully logged out"
    session[:logged_in_as_user] = nil
    redirect_to root_path
  end
end
