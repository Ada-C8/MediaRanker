class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    find_user
  end

  def login_form
  end

  def login
    if session[:user_id] == nil
      user = User.find_by(name: params[:name])
      if user
        session[:user_id] = user.id
        flash[:message] = "Successfully logged in as existing user #{ user.name }"
        redirect_to root_path
      else
        build_new_user
      end
    else
      flash[:status] = :failure
      flash[:message] = "You are already logged in as #{User.find_by(id: session[:user_id].to_i).name}"
      redirect_to root_path
    end
  end


  def logout
    if session[:user_id]
      session[:user_id] = nil
      flash[:message] = "Successfully logged out"
      redirect_to root_path
    end
  end
end

private
def build_new_user
  # not working? new user is not getting logged in
  user = User.new(name: params[:name])
  if user.save
    session[:user_id] = user.id
    flash[:status] = :success
    flash[:message] = "Successfully created new user #{params[:name]} with ID #{user.id}"
    redirect_to root_path
  else
    flash[:status] = :failure
    flash[:message] = "Username #{params[:name]} was not created"
    render :login_form, status: :bad_request
  end
end

def user_params
  return params.require(:user).permit(:name)
end

def find_user
  @user = User.find_by(id: params[:id])
  unless @user
    head :not_found
  end
end
