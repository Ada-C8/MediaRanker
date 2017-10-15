class UsersController < ApplicationController
  def index
    @users = User.order(:created_at)
  end

  def show
    @user = User.find_by(id: params[:id])
    @user_votes = Vote.where(user_id: params[:id])
    @works = []

    @user_votes.each do |vote|
      @works << Work.find(vote.id)
    end

  end

end
