class VotesController < ApplicationController
  def create
    if !session[:user_id]
      flash[:error] = "You must be logged in to do that."
      redirect_to login_page_path
    else
      @vote = Vote.new
      @vote.user_id = session[:user_id]
      @vote.work_id = params[:id]
      if !@vote.save
        flash[:error] = "You've already voted for that!"
        redirect_back fallback_location: home_path
      else
        flash[:success] = "You voted!"
        redirect_back fallback_location: home_path
      end
    end 

  end
end
