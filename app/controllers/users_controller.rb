class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @head
      head :not_found
    end
  end

  def create # Add Strong Params
    # create_user(params[:user][:name])
  end

  def login_form
  end

  def login
    name = params[:name]
    @user = User.find_by(name: name)

    if @user
      session[:logged_in_session] = @user.id
      flash[:success] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"

      redirect_to root_path
    else
      create_user(name)

      session[:logged_in_session] = @user.id
      # flash[:status] = :success
      flash.now[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"

      redirect_to root_path
    end
  end

  def logout
    session[:logged_in_session] = nil
    flash[:message] = "Successfully Logged Out"

    redirect_to root_path
  end

private

  def users_params
    # params.require(:user).permit(:name)
  end

  def create_user(name)
    @user = User.new(name: name)

    @user.save!
  end

end
