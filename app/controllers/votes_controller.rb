class VotesController < ApplicationController
  def create

  @vote = Vote.new(user_id:session[:user_id], work_id:params[:id])
    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to work_path(params[:id])
    else
      error = @vote.errors.messages
      if !error[:user].empty?
        flash[:error] = "You must log in to do that"
      else
        flash[:error] = "You can't upvote more than once!"
      end
      redirect_to work_path(params[:id])
    end
  end
end
