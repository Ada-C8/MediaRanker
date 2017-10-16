class VotesController < ApplicationController
  # def index
  #   @votes = Vote.all
  # end

  # def upvote
  #   if !session[:user_id]
  #     flash[:error] = "You must log in to do that"
  #     redirect_back(fallback_location: :root)
  #   else
  #     @vote = Vote.new
  #     @vote.user_id = session[:user_id]
  #     @vote.work_id = params[:id]
  #     if !@vote.save
  #       flash[:status] = :error
  #       flash[:message] = "Could not upvote. User has already voted for this work."
  #       redirect_back(fallback_location: :root)
  #     else
  #       flash[:status] = :success
  #       flash[:message] = "Successfully upvoted!"
  #       redirect_back(fallback_location: :root)
  #     end
  #   end
  # end
end
