class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    if session[:logged_in_user] == nil
      redirect_back(fallback_location: work_path(params[:id]))
      flash[:error] = "You must be logged in to vote!"
    else

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

end
