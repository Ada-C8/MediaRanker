class UsersController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = User.find_by(provider: params[:provider], uid: params[:uid])
      if user.nil?
        user = User.from_auth_hash(params['provider'], auth_hash)
        # if user.persisted?
        if user.save
          flash[:status] = :success
          flash[:message] = "Successfully created new user #{user.name}"

        else
          flash[:status] = :failure
          flash[:message] ="Could not create new user"
        end
      else
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:message] = "Successfully logged in as returning user #{user.name}"
      end
      flash[:status] = :failure
      flash[:message] = "Could not create new user"
    end
    redirect_to root_path
  end

end
