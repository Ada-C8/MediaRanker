class SessionsController < ApplicationController
  def login_form
  end

  def login
    user = User.find_by(username: params[:username])

    if user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      #create new user
      new_user = User.new(username: params[:username])
      if new_user.save
        flash[:success] = "Successfully created new user #{new_user.username} with ID #{new_user.id}"
        session[:user_id] = new_user.id
        redirect_to root_path
      end
    end

  end

  def logout
    session.delete(params[:user_id])
    # @current_user = nil
    flash[:success] =  "Successfully logged out"
    redirect_to root_path
  end

end
