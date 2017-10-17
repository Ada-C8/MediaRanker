class VotesController < ApplicationController

  def create
      @vote = Vote.new
      @vote.user_id = session[:user_id]
      @vote.work_id = params[:work_id]
        if @vote.user_id == nil
          flash[:error] = "Must be logged in to vote"
          redirect_to works_path
        else
          if @vote.save
            flash[:success] = "Successfully upvoted!"
            redirect_to works_path
          end
        end
  end
end
