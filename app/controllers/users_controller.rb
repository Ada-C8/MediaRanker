class UsersController < ApplicationController
  def index
    @users = User.order(:created_at)
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to "/404.html"
    end
  end
end
