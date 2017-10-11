class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # def show
  #   # @user = User.find(params[:id])
  # end

  def new
    # @user = User.new
  end

  def create
  #   @user = User.new(
  #   user_params
  #   )
  #   if @user.save
  #     redirect_to user_path
  #   else
  #     render :new
  #   end
  end

  def login_form
  end

  def login
    user_id = params[:user][:user_id]
    user = User.find_by(id: user_id)
    if user
      session[:logged_in_user] = user_id
      redirect_to works_path
    else
      head :not_found
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end
  #
  # def update
  #   @user = User.find(params[:id])
  #   result = @user.update(user_params)
  #
  #   if result
  #     redirect_to user_path(@user.id)
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @user = User.find(params[:id])
  #   if @user.destroy
  #     redirect_to users_path
  #   else
  #     #error message
  #   end
  # end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

end
