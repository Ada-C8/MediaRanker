class VotesController < ApplicationController

  def create
    if !@user
      flash[:failure] = "Must be logged in to vote"
    else
      @vote = Vote.new
      @vote.work_id = params[:work_id]
      @vote.user_id = @user.id
      if @vote.save
        flash[:success] = "Upvoted!"
      else
        flash[:failure] = "You may only vote once"
      end
    end
    redirect_to work_path(params[:work_id])
  end
end
