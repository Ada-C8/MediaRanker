class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new
    @vote.user_id = session[:user_id]
    @vote.work_id = params[:id]

    if @vote.save
      flash[:success] = "Successfully upvoted!"
    end
  end
end
