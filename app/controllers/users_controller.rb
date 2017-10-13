class UsersController < ApplicationController
  def index
    @users = User.order(:created_at)
  end

  def show
  end

  def new
  end

  def create
  end
end
