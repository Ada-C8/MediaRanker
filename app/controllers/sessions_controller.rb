class SessionsController < ApplicationController

  def login_form

  end

  def login
    @user = User.find_by(name: params[:username])

    if user
      flash[:success] = "successfully logged in as #{user.name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "No user found by that name #{ params[:username]}"
      redirect_to root_path
    end
  end

end
