class VotesController < ApplicationController
  def create
    vote = Vote.new
    if session[:user_id] && !already_voted
      vote.user_id = params[:user_id]
      vote.work_id = params[:work_id]
      if vote.save
        flash[:success] = "Vote submitted"
      else
        flash[:error] = "Vote failed to save"
      end
    elsif session[:user_id] && already_voted
      flash[:error] = "You have already voted for this work"
    else
      flash[:error] = "You must be logged in to vote"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def already_voted
    user = User.find_by(id: session[:user_id])
    user.votes.any? { |vote| vote.work_id == params[:id] }
  end
end
