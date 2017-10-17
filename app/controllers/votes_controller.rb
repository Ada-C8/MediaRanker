class VotesController < ApplicationController

  def create
    vote = Vote.new(vote_params)
    vote.user_id = session[:username]
    if vote.save
      flash[:success] = "Successfully upvoted!"
    else
      if vote.user_id == nil
        flash[:error] = "You must be logged in to do that!"
      else
        flash[:error] = "Hey! You've already voted for that!"
      end
    end
    redirect_to works_path
  end

  private

  def vote_params
    params.permit(:work_id)
  end

end
