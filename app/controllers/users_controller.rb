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
        render :login_form
      end

    end
  end

  # def login
  #   name = params[:user][:name]
  #
  #   user = User.find_by(name: name)
  #
  #   if user
  #     session[:logged_in_user] = user.id
  #     redirect_to root_path
  #   else
  #
  #   end
  # end

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
