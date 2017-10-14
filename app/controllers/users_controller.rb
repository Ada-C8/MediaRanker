class UsersController < ApplicationController
  def index
    @users = User.order(:created_at)
  end

  def show
    @user = User.find_by(id: params[:id])
    @user_votes = Vote.where(user_id: params[:id])
    @works = Work.all

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
