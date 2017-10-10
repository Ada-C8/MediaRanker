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
    @user.save
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

#do not need these?
  def update
  end
  def destroy
  end
  def edit
  end

  private
  def user_params
    return params.require(:user).permit(:name)
  end


end
