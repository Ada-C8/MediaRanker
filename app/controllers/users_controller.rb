class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id].to_i)
    unless @user
      render_404
    end
  end
end
