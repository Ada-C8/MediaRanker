class VotesController < ApplicationController

  # def up_vote
  #   # check that user is logged in
  #   # if yes than check to see if session user_id matches the votes user id than
  #
  # end

  # def create
  #   # if user is logged in then allow voting
  #   # else do not allow voting
  #
  #   @vote = Vote.new(vote_params)
  #   if @vote.save
  #     flash[:message] = "Successfully upvoted!"
  #     flash[:status] = :success
  #   else
  #     flash[:message] = "You've already voted for this work"
  #     flash[:status] = :failure
  #   end
  #   redirect_to works_path
  # end

  # private
  #
  # def vote_params
  #   return params.permit(:work_id)
  # end
end
