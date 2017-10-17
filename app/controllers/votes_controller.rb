class VotesController < ApplicationController

  def create
    user_id = session[:user_id]
    work_id = params[:id].to_i
    @vote = Vote.new(user_id: user_id, work_id: work_id)

    if session[:user_id].nil?
      flash[:failure] = "You must be logged in to upvote a work!"
      redirect_to login_path
    elsif Vote.where(user_id: user_id, work_id: work_id) != []
      flash[:failure] = "You can only upvote the same work once!"
      redirect_back(fallback_location: root_path)
    elsif @vote.save
      flash[:success] = "Successfully upvoted #{Work.find(work_id).title}!"
      redirect_back(fallback_location: root_path)
    else
      flash[:failure] = "Could not upvote work"
      redirect_to root_path
    end
  end
end
