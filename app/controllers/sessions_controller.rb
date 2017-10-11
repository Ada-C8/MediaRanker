class SessionsController < ApplicationController

  def login_form
  end

  def login
    @user = User.find_by(name: params[:name])
    if @user
      flash[:success] = "Successfully logged in as existing user #{@user.name}"
      session[:user_id] = @user.id
      session[:user] = @user.name
      redirect_to root_path
    else
      @user = User.new(name: params[:name])
      if @user.save
        flash[:success] = "Successfully created new user #{@user.name} with ID #{@user.id}"
        session[:user_id] = @user.id
        session[:user] = @user.name
        redirect_to root_path
      else
        @work = @user
        flash[:error] = "A problem occurred: Could not log in"
        render :login_form
      end
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user] = nil
    flash[:success] = "Successfully Logged Out"
    redirect_to root_path
  end
end
