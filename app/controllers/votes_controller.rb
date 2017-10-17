class VotesController < ApplicationController

  def create
    vote = Vote.new(vote_params)
    user = session[:logged_in_user]

    if user
      vote.user_id = user["id"]
      if vote.save
        flash[:message] = "Successfully upvoted!"
        flash[:status] = :success
      else
        flash[:message] = "Hey! You've already voted for that!"
        flash[:status] = :failure
      end
    else
      flash[:message] = "You must be logged in to do that!"
      flash[:status] = :failure
    end
    redirect_to works_path
  end

private
  def vote_params
    params.permit(:work_id)
  end
end
