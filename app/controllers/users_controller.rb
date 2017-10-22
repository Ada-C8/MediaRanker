class UsersController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
      if user.nil?
        user = User.from_auth_hash(auth_hash['provider'], auth_hash)
        # user.save
        # if user.persisted?
        if user.save
          session[:user_id] = user.uid
          flash[:status] = :success
          flash[:message] = "Successfully created new user #{user.name}"

        else
          flash[:status] = :failure
          flash[:message] ="Could not create new user 1"
        end
      else
        session[:user_id] = user.uid
        flash[:status] = :success
        flash[:message] = "Successfully logged in as returning user #{user.name}"
      end
    else
      flash[:status] = :failure
      flash[:message] = "Could not create new user 2"
    end
    redirect_to root_path
  end

end
