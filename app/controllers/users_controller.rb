class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    find_user
    render_404 if !@user
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end
end

private

def find_user
  @user = User.find_by(id: params[:id])
end

def render_404
  render file: "/public/404.html", status: 404
end
