class SessionsController < ApplicationController
  def login
    @user = User.find_by(name: params[:name])
    if @user
      flash[:success] = "Logged in as #{@user.name}"
      session[:user_id] = @user.id
      session[:user] = @user.name
      redirect_to root_path
    else
      @user = User.new(name: params[:name])
      if @user.save
        flash[:success] = "New user #{@user.name} with ID #{@user.id}"
        session[:user_id] = @user.id
        session[:user] = @user.name
        redirect_to root_path
      else
        @work = @user
        flash[:error] = "A problem occurred. Log in Failed."
        render :log_form
      end
    end
  end

  def logout
  end

  def destroy
    def destroy
      session[:user_id] = nil
      session[:user] = nil
      flash[:success] = "Log out successful"
      redirect_to root_path
    end
  end
end
