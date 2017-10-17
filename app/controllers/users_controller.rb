class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    find_user_by_id
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)

    if user
      session[:logged_in_user] = user.id
      flash[:success] = "Successfully logged in as #{ user.name }!"
      redirect_to root_path
      return
    else
      user = User.create(name: name)
      session[:logged_in_user] = user.id
      redirect_to root_path #request.referrer
      return
    end

  end
  #
  # def logout
  #   session.delete(:user_id)
  #   redirect_to root_path
  # end

  # def reset_session
  #   @_request.reset_session
  # end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def find_user_by_id
    puts "<<<<<<<<<<<<<<<<<< running the test"
    @user = User.find_by(id: params[:id])
    puts "<<<<<after user find by"
    unless @user
      puts "<<<< made it past the unless statement"
      head :not_found
    end
    return @user
  end

end
