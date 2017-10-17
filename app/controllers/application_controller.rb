class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :logged_in_user

  private

  def logged_in_user
    @user = User.find_by(id: session[:user_id].to_i)
  end
end
