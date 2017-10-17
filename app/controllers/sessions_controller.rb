class SessionsController < ApplicationController

  def new
  end

  def create
  end

  def login
    @user = User.find_by(name: params[:user][:name])
    if @user
      session[:logged_in_user] = @user.id
      flash[:status] = :success
      flash[:message] = "Succesfully logged in as existing user #{@user.name}"
      redirect_to root_path
      return
    end

    @user = User.new(name: params[:user][:name])
    if @user.save
      session[:logged_in_user] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
      redirect_to root_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Username can't be blank"
      render :login_form, status: :bad_request
    end
  end

  def logout
    session[:logged_in_user] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_back(fallback_location: root_path)
  end
end
