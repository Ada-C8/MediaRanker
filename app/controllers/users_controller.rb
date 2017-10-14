class UsersController < ApplicationController
  def index
    @users = User.all
  end
end

def show
  find_user_by_id
end

def new
  @user = User.new
end

def create
  @User = User.new(user_params)

  if @user.save
    redirect_to users_path
    return
  else
    render :new, status: :bad_request
    return
  end

  def login
    user_id = params[:user][:user_id]

    user = find_user_by_id
    if user
      session[:logged_in_user] = user_id
      flash[:success] = "Successfully logged in as #{ user.name }!"
      redirect_to root_path
    end

  end

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
