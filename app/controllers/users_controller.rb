class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
    render :login_form
  end

  def login
    #tengo que quitat el user?????
    name = params[:name]
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{name}"
      redirect_to works_path
    else
      user = User.new(name: name, join_date: Date.today )
      user.save
      session[:logged_in_user] = user.id
      redirect_to works_path
      flash[:status] = :success
      flash[:message] = "Successfully log in as a new user"
    end
  end

  def logout
    session[:logged_in_user] = nil
    redirect_to works_path
  end
end
