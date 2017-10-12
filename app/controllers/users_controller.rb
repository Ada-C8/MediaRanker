class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new

  end

  def create

  end

  def show

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
      flash.now[:status] = :failure
      flash.now[:message] = "No user found with name #{name}"
      render :login_form, status: :bad_request
    end
  end

end
