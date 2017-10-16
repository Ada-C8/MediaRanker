require 'pry'
class SessionsController < ApplicationController

  def login_form
  end

  def login
    if find_user(params[:username])
      # flash[:success] = "Successfully loggin in as #{@user.name}"
      # session[:user_id] = @user.id
      # redirect_to root_path
    else
      @user = User.new user_params
      if @user.save
        flash[:success] = "Successfully loggin in as #{@user.name}"
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash.now[:error] = "User not logged in successfully"
        render :login_form
      end
    end
  end
end

private
def find_user(input_name)
  User.all.each do |user|
    @user = user if user.name == input_name
  end
  if @user
    return @user
  else
    return nil
  end
end

def user_params
  return params.require(:user).permit(:name)
end
