class UsersController < ApplicationController
  def index
    @user = User.find_by(id: params[:id])
  end

  def show
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
