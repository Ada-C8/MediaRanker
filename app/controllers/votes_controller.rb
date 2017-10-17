class VotesController < ApplicationController
  include ApplicationHelper

  def upvote
    work = Work.find_by(id: params[:id])

    # if work not found
    unless work
      head :bad_request
      return
    end

    # if not logged in
    if !logged_in?

      flash[:status] = :failure
      flash[:message] = "You must be logged in to upvote"
      redirect_back fallback_location: root_path
      #, status: :unauthorized
      return
    end

    # if logged in
    new_vote = Vote.new(user_id: session[:user_id], work_id: work.id)

    if new_vote.save
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"

      redirect_back fallback_location: root_path

    else
      flash[:status] = :failure
      flash[:message] = "Unable to upvote"
      flash[:details] = new_vote.errors.messages

      redirect_back fallback_location: root_path
      #, status: :bad_request
    end

  end

end
