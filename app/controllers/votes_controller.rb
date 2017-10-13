class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params)
    vote.user_id = session[:user_id]
    if vote.save
      flash[:message] = "Successfully upvoted!"
    else
      flash[:message] = "Hey! You've already voted for that!"
    end
    redirect_to works_path
  end

  private
  def vote_params
    params.permit(:work_id)
    # params.require(:vote).permit(:work_id)
  end
end
