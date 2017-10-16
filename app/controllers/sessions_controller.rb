class SessionsController < ApplicationController

  def login_form
  end

  def create
    name = params[:name]
    @user = User.find_by(name: name)

    if @user
      session[:logged_in_session] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"

      redirect_to root_path
    else
      new_user_for_session(name)
    end
  end

  def destroy
    reset_session
    flash[:status] = :success
    flash[:message] = "Successfully Logged Out"

    redirect_to root_path
  end

  private

  def new_user_for_session(name)
    @user = User.new(name: name)

    if save_and_flash(@user)
      session[:logged_in_session] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as existing user #{@user.name}"
      redirect_to root_path
    else
      flash[:status] = :failure
      render :login_form, status: :bad_request
    end
  end # Def

end # Des
