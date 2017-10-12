class VotesController < ApplicationController
  def create
    if session[:user_id] == params[:user_id]
      vote = Vote.new(vote_params)
      if vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "The vote was not valid"
      end
    else
      flash[:error] = "Please log in before voting"
    end
    redirect_back(fallback_location: works_path)
  end

  private
  def vote_params
    params.permit(:user_id, :work_id)
  end
end
