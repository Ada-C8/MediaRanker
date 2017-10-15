class UsersController < ApplicationController

  def index
    @users = User.order(:username)
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  private
  def user_params
    return params.require(:user).permit(:username)
  end
end
