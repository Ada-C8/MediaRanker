class VotesController < ApplicationController

  def create
    if session[:logged_in_as_user]
      @vote = Vote.new(user_id: session[:logged_in_as_user], work_id: params[:work])

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash[:failure] = "Could not upvote"
        redirect_back(fallback_location: root_path)
      end
    else
      flash.now[:failure] = "You must log in to do that"
    end
  end
end
