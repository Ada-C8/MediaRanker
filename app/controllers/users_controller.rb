class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    if !@user
      render_404
    end
  end

    def create
      @user = User.create(user_params)
    end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
