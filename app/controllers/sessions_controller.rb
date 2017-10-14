class SessionsController < ApplicationController

  def login_form
  end

  def login
    if User.find_by(username: params[:name])
      session[:user] = params[:name]
    else
      user = User.new(username: params[:name])
      if user.save
        flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
        redirect_to root_path
      else
        flash.now[:error] = "A problem occurred: Could not log in"
        render login_path, status: bad_request
      end
    end
  end
end
