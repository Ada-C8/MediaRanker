class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      render_404
    end
  end

  private
  def render_404
    render file: "/public/404.html", status: 404
  end
end
