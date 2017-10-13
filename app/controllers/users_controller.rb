class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new, status: :bad_request
    end
  end

  def show
    find_user_by_params_id
  end

  # no need for an edit, update, or destroy actions for user controller!

private
  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
    return @user
  end

  def user_params
    return params.require(:user).permit(:username)
  end
end
