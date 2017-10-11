class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:user][:username])
    if @user.save
      redirect_to users_path
    else
      render :new
    end

    
  end

  # def edit
  #   @user = User.find_by(id: params[:id])
  #   unless @user
  #     redirect_to users_path
  #   end
  # end
  #
  # def update
  #   @user = User.find_by(id: params[:id])
  #   result = @user.update({
  #     username: params[:user][:name]
  #     })
  #     if result
  #       redirect_to user_path(@user.id)
  #     else
  #       render :edit
  #     end
  # end

  def destroy
    user = User.find_by(id: params[:id])

    if user.destroy
      redirect_to user_path
    else

    end
  end

end
