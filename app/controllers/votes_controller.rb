class VotesController < ApplicationController

  def create
    vote = Vote.new(vote_params)
    user = session[:logged_in_user]
    # binding.pry

    if user
      vote.user_id = user["id"]
      if vote.save
        flash[:message] = "Successfully upvoted!"
      else
        flash[:message] = "Hey! You've already voted for that!"
      end
    else
      flash[:message] = "You must be logged in to do that!"
    end
    redirect_to works_path
  end

  private
  def vote_params
    params.permit(:work_id)
  end
end
