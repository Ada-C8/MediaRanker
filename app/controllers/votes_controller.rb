class VotesController < ApplicationController


  def create
    unless session[:logged_in_user]
      flash.now[:status] = :failure
      flash.now[:message] = "You must be logged in to do that"
      redirect_back
      returns
    end
       @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    if @vote.save
      flash.now[:status] = :success
      flash.now[:message] = "Succesfully upvoted"
    else
      flash.now[:status] = :failure
      flash.now[:message] = "user has already voted for this work"
    end
  end

  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
