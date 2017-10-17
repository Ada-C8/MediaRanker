module ApplicationHelper

  # returns true if user is logged in
  def logged_in?
    return session[:user_id] ? true : false
  end

end
