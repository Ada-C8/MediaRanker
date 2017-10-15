class UsersController < ApplicationController
  def index
    @users = User.order(:username)
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      render_404
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{params[:username]} with ID #{user.id}"
      redirect_to root_path
    else
      flash.now[:error] = "Oops! Username #{params[:username]} was not added successfully"
      render :login_form
    end
  end

  def login_form
  end

  def login
    if session[:user_id] == nil
      user = User.find_by(username: params[:username])
      if user
        flash[:message] = "Successfully logged in as existing user #{ user.username }"
        session[:user_id] = user.id
        redirect_to root_path
      else
        create
      end
    end
  end

  private

  def render_404
    render file: "/public/404.html", status: 404
  end

  def user_params
    return params.require(:user).permit(:username)
  end
end
