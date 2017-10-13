class SessionsController < ApplicationController

  def login_form

  end

  def login
    @user = User.find_by(username: params[:username])


    if @user
      flash[:success] = "successfully logged in as #{user.name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      @user = User.create(username: params[:username])
      flash[:error] = "successfully created User: #{ params[:username]}"
      redirect_to root_path
    end
  end

end
