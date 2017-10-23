class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private


  def require_login
    unless session[:user_id]
      flash[:status] = :failure
      flash[:message] = "You must be logged in to access this section"
      redirect_to root_path, status: 401

    end
  end
end
