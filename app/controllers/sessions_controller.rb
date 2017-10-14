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

end
