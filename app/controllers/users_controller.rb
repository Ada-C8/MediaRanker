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
    # @user = User.new
  end

  def create
    @user= User.find_by(id: params[:id])
    if @user.save
      flash[:success] = "User added successfully"
      redirect_to works_path
    else
      flash.now[:error] = "Work not added successfully"
      render :new
    end
  end

  def destroy
  end
end
