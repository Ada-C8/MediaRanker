class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.new(name: params[:user][:name])

    if save_and_flash(@user)
      session[:logged_in_user] = @user.id
      redirect_to root_path
    else
      render :login_form, status: :bad_request
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    head :not_found unless @user
  end

  def login_form

  end

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(provider: params[:provider], uid: auth_hash['uid'])

      if user.nil?
        user = User.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(user)
      else
        flash[:status] = :success
        flash[:message] = "Successfully logged in as returning user #{user.name}"
      end

      session[:user_id] = user.id

    else
      flash[:status] = :failure
      flash[:message] = "could not create user from OAuth data"
    end
    redirect_to root_path
    # name = params[:user][:name]
    #
    # @user = User.find_by(name: name)
    #
    # if @user
    #   session[:logged_in_user] = @user.id
    #   redirect_to root_path
    #   flash[:status] = :success
    #   flash[:message] = "Successfully logged in as existing user #{@user.name}"
    # else
    #   create
    #   # Successfully created new user aweoituwelgnweb with ID 425
    # end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
  end

end
