class UsersController < ApplicationController
  def index
    @users = User.order(:id)
  end

  def show
  end

  def login_form
  end

  def login
    user_id =  params[:user][:user_id]
    @user = User.find_by(id: user_id)
    if @user
      session[:logged_in] = user_id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"
      redirect_to root_path

    elsif @user.save
      # if User.where(name: params[:name])
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"
      redirect_to root_path
    end

  end

  private
  def user_params
    return params.require(:user).permit(:name, :created_at)
  end
end
