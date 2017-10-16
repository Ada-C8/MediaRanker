class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
  end

  def login
    if User.find_by_name(params[:name]) != nil
      @user = User.find_by_name(params[:name])
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.create(name: params["name"])
      unless @user.id == nil
        session[:user_id] = @user.id
        flash[:status] = :success
        flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
        redirect_to root_path
      else
        flash[:status] = :error
        flash[:message] = "did not succesfully login"
        render "login"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end


  private
    def user_params
      params.require(:user).permit(:name)
    end
end
