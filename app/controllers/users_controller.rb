class UsersController < ApplicationController
  def index
    @users = User.all
  end # index

  def show
    find_user_by_params_id
  end # show

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
