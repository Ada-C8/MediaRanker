class UsersController < ApplicationController
  def index
    @users = User.all
  end # index

  def show
    find_user_by_params_id
  end # show

  def login
    # set the username
    username = params[:user][:name]

    # check if the user already exists
    user = User.first
    if user
      session[:logged_in_user] = user.id
      redirect_to root_path
    else
      # TODO: add logic here to create a new user if the user doesn't already exist
      @user = User.new(user_params)

      if @user.save
        redirect_to root_path
      else
        render :login
      end # if/else
    end # if/else
  end # login


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
