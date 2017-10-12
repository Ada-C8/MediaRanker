class VotesController < ApplicationController


  def create
    vote = Vote.new(vote_params)
    vote.user_id = session[:user_id]
    if vote.save
      flash[:success] = "Successfully upvoted!"
    else
      flash[:error] = "The vote was not valid"
    end
    redirect_to works_path
  end



  private
  def vote_params
    params.permit(:work_id)
  end
end
