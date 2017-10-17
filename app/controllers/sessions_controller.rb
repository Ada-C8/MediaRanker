class SessionsController < ApplicationController

  def login_form

  end

  def login
    @current_user = User.find_by(username: params[:username])
    # log in with existing username
    if @current_user
      session[:user_id] = @current_user.id
      flash[:success] = "successfully logged in as #{@current_user.username}"
      redirect_to root_path

      # login with new username
    else
      @current_user = User.create(username: params[:username])
      flash[:success] = "successfully created User: #{ params[:username]}"
      session[:user_id] = @current_user.id

      redirect_to root_path

    end
  end

  def destroy
    # @current_user = User.find_by(id: params[:id].to_i)
    # @current_user.destroy

    # User.find_by(id: params[:id]).destroy
    # redirect_to home_index_path

    # set the value of the session hash to nil to end the current session
    session[:user_id] = nil
    redirect_to home_index_path
  end

end
