class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end

  def create # Add strong params
    @vote = Vote.new(
      user_id: params[:vote][:user_id],
      work_id: params[:vote][:work_id]
    )
    if @vote.save
      flash[:message] = "Successfully upvoted"
      redirect_to work_path(@vote.work_id)
    # NEED TO RENDER CANNOT VOTE TWICE ON THE SAME WORKS
    else
      flash[:message] = "Could not upvote"
      redirect_to work_path(@vote.work_id)
    end
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

  private

  # def votes_params
  #   # params.require(:vote).permit(:user_id, :work_id)
  # end
end
