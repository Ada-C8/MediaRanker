class UsersController < ApplicationController
  def index
    @users = User.order(:username)
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      render_404
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Successfully created new user #{params[:username]} with ID #{@user.id}"
      session[:user_id] = @user.id
      session[:user] = @user.username
      redirect_to root_path
    else
      flash.now[:error] = "Oops! Username #{params[:username]} could not be logged in successfully"
      render :login_form
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(username: params[:username])
      if @user
        flash[:success] = "Successfully logged in as existing user #{ @user.username }"
        session[:user_id] = @user.id
        session[:user] = @user.username
        redirect_to root_path
      else
        create
      end
  end

  def destroy
    session[:user_id] = nil
    session[:user] = nil
    flash[:success] = "Successfully Logged Out"
    redirect_to root_path
  end

  private

  def render_404
    render file: "/public/404.html", status: 404
  end

  def user_params
    return params.permit(:username)

    #Bug: return params.require(:user).permit(:username)
    #Fix: https://stackoverflow.com/questions/30825735/param-is-missing-or-the-value-is-empty-parametermissing-in-resultscontrollerup

    #Why remove require? will that still make it a strong params?
  end
end
