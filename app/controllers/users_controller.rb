class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find( params[:id].to_i)

    unless @user
      flash[:error] = "Sorry! User Not Found"
      redirect_to users_path
    end
  end


  def create
    @user = User.new user_params

    if @user.save
      # flash[:success] = "User added successfully"
      redirect_to root_path

    else
      # flash.now[:error] = "User not added"
      render :new
    end
  end


  def update
    @user = User.find_by(id: params[:id].to_i)

    if @user.update_attributes user_params
      redirect_to root_path
    else
      render :edit
    end
  end


  def edit
    @user = User.find_by(id: params[:id].to_i)

    unless @user
      redirect_to users_path
    end
  end


  def destroy
    @user = User.find_by(id: params[:id].to_i)
    @user.destroy
    redirect_to root_path
  end


  def new
    @user = User.new
  end

  private

  def user_params
    # puts params
    # puts params.require(:user).permit(:username)
    return params.require(:user).permit(:username)
  end

end
