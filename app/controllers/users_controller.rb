class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def login_form
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user
      session[:logged_in_user] = user.id
      flash[:notice] = "Successfully logged in as existing user #{name}"
      redirect_to works_path
    else
      @user = User.new(name: name)
      if @user.save
        flash[:status] = :success
        flash[:notice] = "Successfully created new user #{name} with ID #{@user.id}"
        redirect_to works_path
      else
        flash.now[:status] = :failure
        flash.now[:notice] = "Failed to create a new user"
        flash.now[:details] = @user.errors.messages
        render :login_form, status: :bad_request
      end
    end
  end

  def logout
  end

end
