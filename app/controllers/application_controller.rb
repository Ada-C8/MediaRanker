class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :logged_in?


  private
  ###Does below go in the model?

  def require_login
    unless logged_in?
      flash[:error] = "You must log in to do that"
      # redirect_to works_path(params[:id])
      redirect_back(fallback_location: works_path) 
    end
  end
end
