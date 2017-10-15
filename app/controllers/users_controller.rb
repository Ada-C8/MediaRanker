class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to home_path
    else
      render :new
    end
  end


  def user_params
    params.require(:user).permit(:name)
  end
end

# def create
#    @user = User.new(user_params)
#    if @user.save
#      redirect_to users_path
#    else
#      # We know the validations didn't pass
#      render :new, status: :bad_request
#    end
#  end
# def create
#     user = User.create(name: params[:username])
#
#     if user
#       session[:user_id] = user.id
#       flash[:success] = "#{ user.name }, with ID #{user.id} is successfully logged in!"
#       redirect_to works_path
#     end
#   end
