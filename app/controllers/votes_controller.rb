class VotesController < ApplicationController

  def create
    @vote = Vote.new(user_id: params[:user_id], work_id: params[:work_id])
    #get user id from session
    #get work id from params -so needs to be in route
    # vote nested in works
    flash[:success] = "Successfully upvoted!"
    redirect_to works_path(params[:work_id])
  end

  private

  # def vote_params
  #   return params.require(:vote).permit(:user_id)
  # end
end
