class SessionsController < ApplicationController
  def login_form

  end

  def login
    user = User.find_by(name: params[:name])

    if user
      # flash[:success] = "Successfully logged in as #{ user.name }"
      session[:user_id] = user.id
      redirect_to root_path
    else
      # flash[:error] = "No user found by the name #{ params[:name] } "
      redirect_to root_path
    end
  end

end
