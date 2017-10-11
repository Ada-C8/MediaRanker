class UsersController < ApplicationController

  def new

  end
  def create

  end

  def login_form

  end

  def login
    user_id = params[:user][:user_id]
    user = User.find_by(id: user_id)
    if user
      session[:logged_in_user] = user_id
      redirect_to root_path
    else
      head :not_found
    end
  end

end
