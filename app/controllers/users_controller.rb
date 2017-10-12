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
      user = find_by(name: params[:name])
      if user
        session[:user_id] = user.id
        flash[:success] = "Successfully logged in as existing user #{user.name}!"
        redirect_to root_path
      else
        if User.create(name: params[:name])
          user = User.find_by(name: params[:name])
          flash[:success] = "Successfully created and logged in as #{params[:name]} with ID #{user.id}!"
          redirect_to root_path
        else
          flash.now[:error] = "User #{params[:name]} not created."
          render :login_form
        end
      end
    else
      flash[:error] = "You are already logged in as #{User.find_by(id: session[:user_id].to_i).username}"
      redirect_to root_path
    end
  end
  # name = params[:user][:name]
  # user = User.find_by(name: name)
  # if user
  #   session[:logged_in_user] = user.id
  #   redirect_to root_path
  # else
  #   flash[:status] = :failure
  #   flash[:message] = "User not found with name #{name}"
  #   render :login_form, status: :bad_request
  # end

  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:success] = "Successfully logged out"
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
