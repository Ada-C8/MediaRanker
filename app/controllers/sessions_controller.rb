class SessionsController < ApplicationController

  def login
    user = User.find_by(name: params[:name])

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as #{ user.name }!"
      redirect_to root_path
    end
    
  end
end
