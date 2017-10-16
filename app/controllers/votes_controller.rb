class VotesController < ApplicationController
  def create
    if session[:user_id] && !already_voted
      if Vote.create(work_id: params[:id], user_id: session[:user_id])
        flash[:success] = "Vote submitted"
      else
        flash[:failure] = "Vote failed to save"
      end
    elsif session[:user_id] && already_voted
      flash[:failure] = "You have already up-voted this work"
    else
      flash[:failure] = "You must be logged in to vote"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def already_voted
    user = User.find_by(id: session[:user_id])
    user.votes.any? { |vote| vote.work_id == params[:id] }
  end
end
