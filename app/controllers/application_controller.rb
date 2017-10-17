class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def reset_session
    @_request.reset_session
    redirect_to root_path
  end
end
