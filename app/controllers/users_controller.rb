class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def login_form
  end

  def login
  end
end
