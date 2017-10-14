class VotesController < ApplicationController

  def create # Add strong params
    if session[:logged_in_session] == nil
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that"
    end
    # if the user is logged in but the user has
    # else
    #   @vote = Vote.new(votes_params)
    #     # user_id: params[:vote][:user_id],
    #     # work_id: params[:vote][:work_id]
    #   if @vote.save!
    #     flash[:status] = :success
    #     flash[:message] = "Successfully Upvoted!"
    #
    #     redirect_to works_path(@vote.work_id)
    #   else
    #     flash[:status] = :failure
    #     flash[:message] = "Could not upvote"
    #
    #     redirect_to login_path
    #   end
    # end
  end

  private

  def votes_params
    params.require(:vote).permit(:user_id, :work_id)
  end

end
