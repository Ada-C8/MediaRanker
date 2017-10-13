class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    user = User.new(name: params[:user][:name])
    user.save
    return user
  end

  def show
    @user = User.find_by(id: params[:id])
    head :not_found unless @user
  end

  def login_form

  end

  def login
    # user_id = params[:user][:user_id]
    # user = User.find_by(id: user_id)
    name = params[:user][:name]

    user = User.find_by(name: name)

    if user
      session[:logged_in_user] = user.id
      redirect_to root_path
    else
      user = create
      redirect_to user_path(user.id)
      session[:logged_in_user] = user.id
      # flash.now[:status] = :failure
      # flash.now[:message] = "No user found with name #{name}"
      # render :login_form, status: :bad_request
    end
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to root_path
  end

end
