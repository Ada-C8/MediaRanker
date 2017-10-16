class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    find_user_by_params_id
  end

  # like new method
  def login_form
  end


  # like create function
  def login

    user = User.find_by(name: params[:user][:name])

    if user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in existing user #{user.name}"
      redirect_to root_path
    else
      @user = User.new(user_params)

      if @user.save
        session[:logged_in_user] = @user.id
        flash[:status] = :success
        flash[:message] = "Successfully logged in new user #{@user.name}"
        redirect_to root_path
      else
        flash[:status] = :failure
        flash[:message] = "Please type in your username"

        render :login_form, status: :bad_request
      end

    end
  end

  def logout
    session.clear
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

  private
  def user_params
     return params.require(:user).permit(:name)
  end
  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end
end
