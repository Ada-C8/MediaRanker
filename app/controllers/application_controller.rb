class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    raise ActionController::RoutingError.new('Nothing to see here..')
  end

  def user_name
    @current_user = User.find_by_id(session[:user_id])
  end
    #so I can render this in the view , setting up user name

  # def render_404
  #   render file: "/public/404.html", status: 404
  # end

  #which one to use
end
