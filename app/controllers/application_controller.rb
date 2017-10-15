class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    render file: "/public/404.html", status: 404
  end

    before_action :find_work, only: [:show, :edit, :update, :destroy]
end
