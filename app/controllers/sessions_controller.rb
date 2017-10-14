class SessionsController < ApplicationController

  def login_form

  end

  def login
    @user = User.find_by(username: params[:username])

    if @user
      flash[:success] = "successfully logged in as #{user.name}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      @user = User.create(username: params[:username])
      flash[:error] = "successfully created User: #{ params[:username]}"
      redirect_to root_path
    end
  end

  def destroy
    # @user = User.find_by(id: params[:id].to_i)
    # @user.destroy

    # User.find_by(id: params[:id]).destroy
    # redirect_to home_index_path

    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to home_index_path
  end

end
