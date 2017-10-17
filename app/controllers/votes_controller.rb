class VotesController < ApplicationController

  def create
    unless session[:logged_in_user]
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that"
      redirect_back(fallback_location: root_path)
      return
    end
       @vote = Vote.new(user_id: session[:logged_in_user], work_id: params[:work_id])

    if @vote.save
      flash[:status] = :success
      flash[:message] = "Succesfully upvoted"
      redirect_back(fallback_location: root_path)
    else
      flash[:status] = :failure
      flash[:message] = "user has already voted for this work"
      redirect_back(fallback_location: root_path)
    end
  end

end
