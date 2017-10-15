class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    work = params[:id].to_i
    user = session[:logged_in_user]['id']
    @vote = Vote.new(user_id: user, work_id: work)

    @vote.save
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: work_path(params[:id]))
    else
      flash[:failure] = "You cannot upvote twice!"
      redirect_back(fallback_location: work_path(params[:id]))
    end
  end

end
