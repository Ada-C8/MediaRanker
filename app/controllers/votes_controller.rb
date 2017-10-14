class VotesController < ApplicationController

  def create
    if session[:logged_in_as_user]
      @vote = Vote.new(vote_params)

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash.now[:error] = "Could not upvote"
        #re-direct necessary?
      end
    else
      flash.now[:error] = "You must log in to do that"
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user, :work)
  end
end
