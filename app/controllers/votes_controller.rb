class VotesController < ApplicationController

  before_action :require_login

  def create
  #def upvote
    # user = User.find_by(id: params[:id])
    # user = User.find_by(username: params[:username])
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:id])

    @vote = Vote.new
    @vote.user = user
    @vote.work = work

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      #TODO: redirect to the same page you were on
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Could not upvote"
    end

  end


end
