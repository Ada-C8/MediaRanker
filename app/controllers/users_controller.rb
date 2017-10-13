class UsersController < ApplicationController

  def index
    @users = User.order(:username)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Successfully created User #{@user.username}!"
      redirect_to user_path(@user.id)
    else
      flash.now[:error] = "A problem occurred: Could not create User #{@user.username}"
      render :new
    end
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
