class VotesController < ApplicationController
  def upvote
    vote = Vote.new
    vote.user_id = session[:logged_in_user]
    vote.work_id = params[:id]
    vote.save
    flash[:success] = "You have successfully voted for this work"
    redirect_to works_path
  end
end
