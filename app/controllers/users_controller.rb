class UsersController < ApplicationController
  def index
    @users = User.order(:name)
  end

  def show
    @user = User.find_by(id: params[:id].to_i)
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end
end
