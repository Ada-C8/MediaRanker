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
