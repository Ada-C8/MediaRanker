class VotesController < ApplicationController
  def new
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.save
    redirect_to works_path
  end

  private

  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end


end
