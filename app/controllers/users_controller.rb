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
    name = params[:name]
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user.id
      redirect_to works_path
    else
      user = User.new(name: name, join_date: Date.today )
      user.save
      session[:logged_in_user] = user.id
      redirect_to works_path
    end
  end
end
