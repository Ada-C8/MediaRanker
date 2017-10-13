class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    existing_user= User.find_by(username: user_params)

    @user.save unless existing_user
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end


  ##should reserve this for sessions controller?
  # def login
  #   existing_user = User.find_by(username: params[:username])
  #
  #   if existing_user
  #     flash[:success] = "Successfully logged in as existing user #{existing_user.username}"
  #     session[:user_id] = existing_user.id
  #     redirect_to root_path
  #   elsif @user.save
  #     flash[:success] = "Successfully created new user #{@user.username} with ID #{@user.id}"
  #     redirect_to root_path
  #   else
  #     flash[:error] = "User not created"
  #     render :new
  #   end
  #
  # end
end
