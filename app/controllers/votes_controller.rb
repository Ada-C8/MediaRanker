class VotesController < ApplicationController
  def create
    vote = Vote.new(vote_params)
    if vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: works_path)
    else
      flash.now[:error] = "The vote was not valid"
    end
  end

  private
  def vote_params
    params.permit(:user_id, :work_id)
  end
end
