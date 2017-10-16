class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    if session[:logged_in_user] == nil
      redirect_back(fallback_location: works_path)
      flash[:error] = "You must be logged in to vote!"

    elsif params[:id] == nil
      flash[:error] = "That piece of media doesn't exist!"

    else
      work = params[:id].to_i
      user = session[:logged_in_user]['id']
      @vote = Vote.new(user_id: user, work_id: work)
      @vote.save

      if @vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: work_path(params[:id]))
      else
        flash[:failure] = "You cannot upvote twice!"
        redirect_back(fallback_location: works_path)
      end
    end

  end

end
