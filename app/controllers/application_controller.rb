class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user_session
end
private
def find_user_session
  @session_user = nil
  User.all.each do |user|
    @session_user = user if user.id == session[:user_id]
  end
  return @session_user
end
