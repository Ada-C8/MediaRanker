class UsersController < ApplicationController
  before_action :find_user_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    if save_and_flash(@user)
      redirect_to users_path
    else
      render :new, status: :bad_request
    end
  end

  def login
    username = params[:email]
    user = User.find_by(username: username)
    # session is created in Rails when the user arrives on the app. A session is a hash and we are filling it with a key-value pair.
    session[:uid] = user.id
  end

  # votes#create
  def create
    user_id = session[:uid]
    current_user = User.find(user_id)
    Vote.create(work: work, user: current_user)
    # session[:uid] = user.id # may not need this line of code
  end

  def show ; end

  def edit ; end

  def update
    @user.update_attributes(user_params)
    if save_and_flash(@user)
      redirect_to user_path(@user)
      return
    else
      render( :edit, {status: :bad_request})
      return
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end

  def find_user_by_params_id
    @user = User.find_by(id: params[:id])

    unless @user
      head :not_found
    end
  end
end
