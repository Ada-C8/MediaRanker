class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :user_in_session

  def render_404
    render file: "/public/404.html", status: 404
  end

  private

  def user_in_session
    @user_in_session = User.find_by(id: session[:user_id])
  end
end
