class VotesController < ApplicationController
  def upvote
    if session[:logged_in_user]
      current_work_id = params[:id]
      user_id = session[:logged_in_user]

      vote = Vote.new(user_id: user_id, work_id: current_work_id)
      if vote.save
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
      else
        flash[:status] = :failure
        flash[:message] = "Can't vote for the same work twice!"
      end
    else
      flash[:status] = :failure
      flash[:message] = "You must be logged in to vote"
    end

    #TODO: not working, always redirecting to works_path

    if request.referer.include?(works_path)
      redirect_back(fallback_location: works_path)
    else
      redirect_back(fallback_location: work_path(current_work_id))
    end

  end
end
