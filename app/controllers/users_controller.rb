class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
  end


  def login_form
    @user = User.new
    if params[:user_id]
      @user.user_id = params[:user_id]
    end
  end

  def login
    @user = User.new(user_params)

    if save_and_flash(@user)
      redirect_to root_path
    else
      render :new, status: :bad_request
    end
  end

  private
  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end
end
