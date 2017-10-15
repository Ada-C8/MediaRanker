class VotesController < ApplicationController

  def create
    user_id = session[:user_id]
    work_id = params[:id].to_i
    @vote = Vote.new(user_id: user_id, work_id: work_id)
    if @vote.save
      flash[:success] = "Successfully upvoted #{Work.find(work_id).title}!"
      redirect_to root_path
    else
      flash[:failure] = "Could not upvote work"
      redirect_to root_path
    end
  end
end
