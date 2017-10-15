class VotesController < ApplicationController

  def create
      @vote = Vote.new
      @vote.user_id = session[:user_id]
      @vote.work_id = params[:work_id]
        if @vote.save
          flash[:success] = "Successfully upvoted!"
          redirect_to works_path
        end
  end
end
