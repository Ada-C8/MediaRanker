class VotesController < ApplicationController

  def create # Add strong params
    @vote = Vote.new(votes_params)

    # Did not place in save_and_flash due to flash not showing up on redirect
    if session[:logged_in_session] != nil
      if @vote.save # Only save if the work was not previously voted on
        flash[:status] = :success
        flash[:message] = "Successfully Upvoted!"

        redirect_to work_path(@vote.work_id)
      else
        # If the @vote was not saved because the user already has voted on the same work or the user is not signed in
        flash[:status] = :failure
        flash[:message] = "Could not upvote"
        flash[:details] = @vote.errors.messages

        redirect_to work_path(@vote.work_id)
      end
    else
      flash.now[:status] = :failure
      flash.now[:message] = "You must be logged in to do that"
    end
  end

  private

  def votes_params
    params.require(:vote).permit(:user_id, :work_id)
  end

end
