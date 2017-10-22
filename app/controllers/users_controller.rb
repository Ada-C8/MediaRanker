class UsersController < ApplicationController
  def show
    @user = User.find_by(uid: session[:user_id])
  end
  def index
    @users = User.all
  end
  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
      if user.nil?
        user = User.from_auth_hash(auth_hash['provider'], auth_hash)
        # if user.persisted?
        if user.save
          session[:user_id] = user.uid
          flash[:status] = :success
          flash[:message] = "Successfully created new user #{user.name}"

        else
          flash[:status] = :failure
          flash[:message] ="Could not create new user"
        end
      else
        session[:user_id] = user.uid
        flash[:status] = :success
        flash[:message] = "Successfully logged in as returning user #{user.name}"
      end
    else
      flash[:status] = :failure
      flash[:message] = "Could not create new user because of a oauth problem"
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "You successfully logged out"
    redirect_to root_path
  end

end
