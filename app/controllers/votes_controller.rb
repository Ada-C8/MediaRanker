class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
  end


  private
  def vote_params
    return params.permit(:user.id, :work_id)
  end # vote_params
end
