class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def show
    @vote = Vote.find(params[:id])
  end

  def new
    @vote = Vote.new
  end

  def create # Add strong params
    vote = Vote.new(
      user_id: params[:vote][:user_id],
      work_id: params[:vote][:work_id]
    )
    vote.save
    redirect_to works_path(vote.work_id)
    # Add redirect_to
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @vote = Vote.find(params[:id])
    # Do we use the update method for vote?
  end

  def destroy
    @vote = Vote.find(params[:id])
    # We do not need the destroy method for vote
  end
end
