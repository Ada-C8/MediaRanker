require 'date'

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name])

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: "log in successful!"
    else
      flash.now.alert = 'Invalid email or password'
      render "new       "
    end
  end

  def destory
    session[:user_id] = nil
    redirect_to root_url
  end
end
