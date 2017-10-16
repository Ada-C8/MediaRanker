class SessionsController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    user = User.new(name: params[:name])

    if user.save
      flash[:success] = "Successfully logged in as #{user.name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "No user was created by the name #{params[:name]} "
      redirect_to root_path
    end
  end

  def create
    render 'new'
  end


  # "Delete" a login, aka "log the user out"
  #taken from http://guides.rubyonrails.org/action_controller_overview.html#session
  def logout
    # Remove the user id from the session
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_url
  end

  private

  def current_user
   @current_user ||= User.find_by(id: session[:user_id])
  end

end
