class VotesController < ApplicationController

  def index
    @votes = Vote.order(:id)
  end

  def create
    if session[:user_id] == nil
      flash[:error] = "Must be logged in to vote"
      redirect_to root_path
    else
      @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path(params[:work_id])
      else
        flash[:error] = "Vote not recorded"
        redirect_to works_path(params[:work_id])
      end
    end
  end

end
