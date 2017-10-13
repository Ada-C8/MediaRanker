class UsersController < ApplicationController

  def index
    @users = User.order(:username)
  end

  def new
  end

  def edit
  end

  def show
  end
end
