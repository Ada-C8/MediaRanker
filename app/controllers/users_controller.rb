class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to login_path
    # if @user.save
    #   flash[:success] = "Welcome New User!"
    #   redirect_to works_index_path
    # else
    #   render :new
    # end
  end

  def login_form
  end


  def login
    username = params[:user][:username]

    user = User.find_by(username: username)

    if user
      session[:logged_in_user] = user.id
      redirect_to works_index_path
    else
      flash.now[:status] = :failure
      flash.now[:message] = "No such user exists."
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

end
