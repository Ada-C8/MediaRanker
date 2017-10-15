class SessionsController < ApplicationController

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

  def login_form
  end

  def destroy
    #session[:logged_in_session] = nil
    reset_session
    flash[:message] = "Successfully Logged Out"

    redirect_to root_path
  end

  private

  def new_user_for_session(name)
    @user = User.new(name: name)

    if @user.save
      session[:logged_in_session] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{@user.name} with ID #{@user.id}"

      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:details] = @user.errors.messages

      render :login_form, status: :bad_request
    end
  end # Des
end # Des
