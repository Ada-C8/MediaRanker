class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user_session, :logged_in?
end
private
def find_user_session
  @session_user = nil
  User.all.each do |user|
    @session_user = user if user.id == session[:user_id]
  end
  return @session_user
end

def logged_in?
  if !(@session_user)
    flash[:error] = "You must be logged in to browse the site."
    redirect_to root_path
  end
end
