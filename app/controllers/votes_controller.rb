class VotesController < ApplicationController

  def create
    current_user = nil
    if session[:logged_in_user]
      current_user = User.find_by(id: session[:logged_in_user])
    else
      flash[:status] = :failure
      flash[:notice] = "You must be logged in to do that!"
      redirect_back(fallback_location: works_path)
      return
    end

    if current_user.votes.where(work_id: params[:work_id]).present?
      flash[:status] = :failure
      flash[:notice] = "Could not upvote"
      redirect_back(fallback_location: works_path)
      return
    end

    vote = Vote.new(user_id: current_user.id, work_id: params[:work_id])
    vote.save
    flash[:status] = :success
    flash[:notice] = "Successfully upvoted!"
    redirect_back(fallback_location: works_path)

  end

end
