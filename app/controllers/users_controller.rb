class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def login_form
  end

  def login
    # user_id = params[:user][:user_id]
    name = params[:user][:name]

    # user = User.find_by(id: user_id)
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user_id
      redirect_to root_path
    else
      # head :not_found
      flash[:status] = :failure
      flash[:message] = "No user with #{name}"
      render :login_form
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
