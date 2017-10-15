class VotesController < ApplicationController

  def create # Add strong params
    @vote = Vote.new(votes_params)
    if @vote.save # Only save if the work was not previously voted on
      flash[:status] = :success
      flash[:message] = "Successfully Upvoted!"

      redirect_to work_path(@vote.work_id)
    else
      # If the @vote was not saved because the user already has voted on the same work or the user is not signed in 
      flash[:status] = :failure
      flash[:message] = "Could not upvote"
      flash[:details] = @vote.errors.messages

      redirect_to works_path
    end
  end

  private

  def votes_params
    params.require(:vote).permit(:user_id, :work_id)
  end

end
