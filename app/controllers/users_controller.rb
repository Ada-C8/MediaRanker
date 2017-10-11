class UsersController < ApplicationController


  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:logged_in_user] = user.id
      redirect_to root_path

    else
      flash[:status] = :failure
      flash[:message] = "No user found with username #{username}"
      render :login_form, status: :bad_request
    end


  end
end
