class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    find_user_by_params_id
  end

  private

  def find_user_by_params_id
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
    return @user
  end


end
