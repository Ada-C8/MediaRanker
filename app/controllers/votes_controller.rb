class VotesController < ApplicationController

  def create
    current_user
    if !@current_user
      flash[:failure] = "Must be logged in to vote."
    else
      @vote = Vote.new
      @vote.work_id = params[:work_id]
      @vote.user_id = @user.id
      if @vote.save
        flash[:success] = "Upvoted!"
        redirect_back(fallback_location: root_path)
      else
        flash[:failure] = "You may only vote once"
      end
    end
    redirect_to work_path(params[:work_id])
  end
end
