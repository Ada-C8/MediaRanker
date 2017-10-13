class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
  end

  def login
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if User.where(name: params[:name])
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
      redirect_to root_path
      else
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"
      redirect_to root_path
      end
    else
      flash[:status] = :failure
      flash[:message] = "Failed to create user"
      render :new
    end
  end

  private
  def user_params
    return params.require(:user).permit(:name, :created_at)
  end
end
