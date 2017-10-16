class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    if session[:logged_in_user] == nil
      redirect_back(fallback_location: works_path)
      flash[:error] = "You must be logged in to vote!"
      puts "you must be logged in to vote"

    elsif params[:id] == nil
      puts "I'm not getting your id params, BOOTHANG"

    else
      work = params[:id].to_i
      user = session[:logged_in_user]['id']
      @vote = Vote.new(user_id: user, work_id: work)
      @vote.save

      if @vote.save
        puts "it saved!"
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: work_path(params[:id]))
      else
        puts "it didn't save :("
        flash[:failure] = "You cannot upvote twice!"
        redirect_back(fallback_location: works_path)
      end
    end

  end

end
