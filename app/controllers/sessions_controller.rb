class SessionsController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(name: params[:username])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{ @user.name }"
      redirect_to root_path
    else
      @user = User.new
      @user.name = params[:username]
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
        redirect_to root_path
      else
        flash.now[:error] = "A problem occured: Could not log in"
        render :login_form
      end
    end
  end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
    else
      #some sort of alert message
    end
    redirect_to root_path
  end


end
