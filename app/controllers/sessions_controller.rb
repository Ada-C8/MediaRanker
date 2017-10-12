class SessionsController < ApplicationController

  def login_form
  end

  def login
    user = User.find_by(name: params[:username])

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{ user.name }"
      redirect_to root_path
    else
      user = User.new
      user.name = params[:username]
      if user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        render login_path
      end
    end
  end

  def logout
    if session[:user_id]
      session[:user_id] = nil
    else
      #some sort of alert message
    end
    redirect_to root_path
  end


end
