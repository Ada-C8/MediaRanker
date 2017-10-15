class SessionsController < ApplicationController

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by_name(params[:name])

    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}!"
      redirect_to root_path
    else
      user = User.create(name: params[:name])
      if user.id != nil
        session[:user_id] = user.id
        flash[:success] = "Welcome new user #{user.name}."
        redirect_to root_path
      else
        flash.now[:failure] = "User name cannot be blank."
        flash.now[:error] = "Please try again."
        render "login_form"
      end
    end
  end

  def logout
    session.delete(:user_id)
    flash[:success] = "Goodbye!"
    redirect_to root_path
  end
end
