class SessionsController < ApplicationController
  def login
    @user = User.new
  end

  def create
    username = params[:username]
    if username && user = User.find_by(username: params[:username])
      # log em in
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in"
    else
      # no user, try to save
      user = User.new(username: params[:username])
      if user.save
        # successful save
        flash[:status] = :success
        flash[:result_text] = "Successfully created new user!"
        session[:user_id] = user.id
      else
        flash[:status] = :error
        flash[:result_text] = "Something went wrong!"
        render "login", status: :bad_request
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end
end
