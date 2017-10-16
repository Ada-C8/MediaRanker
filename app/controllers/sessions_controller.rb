class SessionsController < ApplicationController

  def login_page
    @users = User.all
  end

  def login
    @user = User.find_by_name(params[:name])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "You're logged in as existing user #{@user.name}"
      redirect_to home_path
    else
      @user = User.create(name: params[:name])
        if @user.id != nil
          session[:user_id] = @user.id
          flash[:success] = "Logged in as new user #{@user.name} with the ID of #{@user.id}."
          redirect_to home_path
        else
          flash[:error] = "Failed to login."
          render :login_page
        end
    end
  end

  def logout
    session[@user_id] = nil
    redirect_to home_path
  end
end
