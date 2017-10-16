require 'pry'
class SessionsController < ApplicationController

  def login_form
  end

  def login
    if find_user(params[:username])
      flash[:success] = "Successfully loggin in as #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user = User.new
      @user.name = (params[:username])
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
  
  def logout
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
