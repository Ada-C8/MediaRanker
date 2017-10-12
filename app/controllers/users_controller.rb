class UsersController < ApplicationController


  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfuly logged in as existing user #{username}"
      redirect_to root_path

    else
      user = User.new(username: username, date_joined: Date.today)
      user.save
      flash[:status] = :success
      flash[:message] = "Successfuly logged in as new user #{username}"
      session[:logged_in_user] = user.id
      redirect_to root_path
      # flash.now[:status] = :failure
      # flash.now[:message] = "No user found with username #{username}"
      # render :login_form, status: :bad_request
    end


  end
end
