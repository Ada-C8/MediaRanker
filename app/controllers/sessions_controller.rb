class SessionsController < ApplicationController

  def login_form
  end

  def login
    user = User.find_by(name: params[:name])

    unless user
      user = User.create(name: params[:name])
    end
    flash[:success] = "Successfully Logged In"
    session[:user_id] = user.id
    session[:user] = user.name
    redirect_to root_path
  end
end
