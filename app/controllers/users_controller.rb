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

  def edit
    @user = User.find(params[:id])
  end

  def create
    strong_params = user_params
    @user = User.new(strong_params)
    @user.save
    redirect_to users_path
  end

  def update



    strong_params = user_params
    @user = User.find(params[:id])
    @user.update_attributes(strong_params)
    @user.save

    #replaces save
    # if save_and_flash(@user)
    #   redirect_to users_path
    #   return
    # else
    #   render :edit, status: :bad_request
    #   return
    # end

  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    redirect_to users_path
  end

private
  def user_params
    return params.require(:user).permit(:name)
  end


end
