class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end

  def new
    @user = User.new
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  def create
    strong_params = user_params
    @user = User.new(strong_params)
    if @user.save
      redirect_to root_path
    else
      render :new, status: :bad_request
    end
  end

  def login_form
  end

  def login
    user_name = params[:user][:name]
    user = User.find_by(name: user_name)
    if user
      session[:logged_in_user] = user.id
    else
      user = User.create!(name: params[:user][:name])
      session[:logged_in_user] = user.id
    end
    redirect_to root_path
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to root_path
    return
  end

  # def update
  #
  #
  #
  #   strong_params = user_params
  #   @user = User.find(params[:id])
  #   @user.update_attributes(strong_params)
  #   @user.save

    #replaces save
    # if save_and_flash(@user)
    #   redirect_to users_path
    #   return
    # else
    #   render :edit, status: :bad_request
    #   return
    # end

  # end

  # def destroy
  #   user = User.find(params[:id])
  #   user.destroy
  #
  #   redirect_to users_path
  # end

private
  def user_params
    return params.require(:user).permit(:name)
  end


end
