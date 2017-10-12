class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
    user_params
    )
    if @user.save
      redirect_to user_path
    else
      render :new
    end
  end

  def login_form
  end

  def login
    if session[:user_id] == nil
      # choose this:
      # name = params[:user][:name]
      # user = User.find_by(name: name)
      # or
      user = User.find_by(name: params[:name])
      if user
        session[:user_id] = user.id
        flash[:message] = "Successfully logged in as existing user #{ user.name }"
        redirect_to root_path
      else
        if User.create(name: params[:name])
          user = User.find_by(name: params[:name])
          session[:user_id] = user.id
          flash[:success] = "Successfully created new user #{params[:name]} with ID #{user.id}"
          redirect_to root_path
        else
          flash[:status] = :failure
          flash[:message] = "Username #{params[:name]} was not created"
          render :login_form, status: :bad_request
        end
      end
    else
      flash[:status] = :failure
      flash[:message] = "You are already logged in as #{User.find_by(id: session[:user_id].to_i).name}"
      redirect_to root_path
    end
  end
  # name = params[:user][:name]
  # user = User.find_by(name: name)
  # if user
  #   session[:X] = user.id
  #   redirect_to root_path
  # else
  #   flash[:status] = :failure
  #   flash[:message] = "User not found with name #{name}"
  #   render :login_form, status: :bad_request
  # end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:message] = "Successfully logged out"
      redirect_to root_path
    end
  end
end



# def edit
#   @user = User.find(params[:id])
# end
#
# def update
#   @user = User.find(params[:id])
#   result = @user.update(user_params)
#
#   if result
#     redirect_to user_path(@user.id)
#   else
#     render :edit
#   end
# end
#
# def destroy
#   @user = User.find(params[:id])
#   if @user.destroy
#     redirect_to users_path
#   else
#     #error message
#   end
# end

private

def user_params
  return params.require(:user).permit(:name)
end
