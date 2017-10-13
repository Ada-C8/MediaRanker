class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    raise ActionController::RoutingError.new('Nothing to see here..')
  end

  # def render_404
  #   render file: "/public/404.html", status: 404
  # end


  def user_name
    @current_user = User.find_by_id(session[:user_id])
  end

  #which  one to use
end
