class UsersController < ApplicationController

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

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
    render_404 unless @user
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
