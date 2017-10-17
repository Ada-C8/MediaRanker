class VotesController < ApplicationController

  def upvote

    if session[:username] == nil
      flash[:failure] = "You must log in to do that"
      redirect_to work_path
      return
    end


    if Vote.find_by(user_id: session[:user_id], work_id: params[:id])
      flash[:failure] = "You have already voted for that work"
      redirect_to work_path
    else
      vote = Vote.new
      vote.user_id = session[:user_id]
      vote.work_id = params[:id]
      vote.save
      flash[:success] = "You successfully voted for this work"
      redirect_to work_path
    end
    
  end

end
