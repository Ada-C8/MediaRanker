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
      if user.save
        flash[:status] = :success
        flash[:message] = "Successfuly logged in as new user #{username}"
        session[:logged_in_user] = user.id
        redirect_to root_path
      else
        flash.now[:status] = :failure
        flash.now[:message] = "A problem occurred: Could not log in"
        flash.now[:details] = user.errors.messages
        render :login_form, status: :bad_request
      end
    end
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to root_path, notice: "You have successfully logged out."
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end
end
