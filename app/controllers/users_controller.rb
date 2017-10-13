class UsersController < ApplicationController

   def index
      @users = User.all
    end

    def show
      find_user_by_params_id
    end

    def login_form
    end

    def login
      if params[:user][:name] == ""
        flash[:status] = :failure
        flash[:message] = "Please enter a username"
        render :login_form
      else
        user = User.new(name: params[:user][:name], joined: Date.today)
        user.save
        session[:logged_in_user] = user.id
        flash[:status] = :success
        flash[:message] = "#{ user.name } is successfully logged in"
        redirect_to root_path
      end
    end

    def logout
      session[:logged_in_user] = nil
      flash[:status] = :success
      flash[:message] = "You have been successfully logged out"

      redirect_to root_path
    end

    private

    def find_user_by_params_id
      @user = User.find_by(id: params[:id])
      unless @user
        head :not_found
      end
      return @user
    end

end
