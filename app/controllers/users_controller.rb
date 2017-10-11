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
      render :new, status: :bad_request
    end
  end

  # def login_form
  # end
  #
  # def login
  #   # user_id = params[:user][:user_id]
  #   name = params[:user][:name]
  #
  #   # user = User.find_by(id: user_id)
  #   user = User.find_by(name: name)
  #   if user
  #     session[:logged_in_user] = user_id
  #     redirect_to root_path
  #   else
  #     # head :not_found
  #     flash[:status] = :failure
  #     flash[:message] = "No user with #{name}"
  #     render :login_form
  #   end
  # end

  def show
    find_user_by_params_id
  end

  def edit
    find_user_by_params_id
  end

  def update
    if find_user_by_params_id
      @user.update_attributes(user_params)
      if @user.save
        redirect_to user_path(@user)
        return
      else
        render :edit, status: :bad_request
        return
      end
    end
  end

  def destroy
    if find_user_by_params_id
      @user.destroy
      redirect_to users_path
    end
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
    return @user
  end
end
