class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception




  private
  ###Does below go in the model?

  # Returns the current logged-in user (if any).
  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  def require_login
    unless logged_in?
      flash[:error] = "You must log in to do that"
      redirect_to works_path(work.id)
    end
  end
end
